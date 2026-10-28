#!/bin/sh
export OLLAMA_VERSION='0.40.12'
CHECKSUM_INSTALL_SH='sha256:25f64b810b947145095956533e1bdf56eacea2673c55a7e586be4515fc882c9f'
CHECKSUM_SHA256SUM_TXT='sha256:59b267a11d968a78fce8198a15184692aac33c6213aa572dc0b935a894bf08fd'

RELEASE_DOWNLOAD_BASE_URL='https://github.com/ollama/ollama/releases/download/v${OLLAMA_VERSION}'
INSTALL_SH_URL="${RELEASE_DOWNLOAD_BASE_URL}/install.sh"

function url {
    local url=$1
    echo -n "$(echo -n "$url" | sed -E "s#\\\$\{OLLAMA_VERSION\}#${OLLAMA_VERSION}#g")"
    return 0
}
function checksum() {
    local file=$1
    local hash=$2
    local url=$(url "${RELEASE_DOWNLOAD_BASE_URL}/${file}")
    if [ -z "$hash" ]; then
        return 0
    fi

    local TEMP_DIR=$(mktemp -d -t "check-ollama-${OLLAMA_VERSION}-${file}-XXXXXX")
    trap 'rm -rf "${TEMP_DIR}"' RETURN INT TERM
    if [ "sha256:$(curl -sSL "${url}" | tee "${TEMP_DIR}/${file}" | sha256sum | awk '{print $1}')" = "${hash}" ]; then
        return 0
    else
        echo "❌ ERRO: O hash SHA256 do arquivo '${file}' não bate! Parando instalação." >&2
        return 1
    fi
}

function checksum-from-release() {
    local file=$1
    local url=$(url "${RELEASE_DOWNLOAD_BASE_URL}/${file}")
    local url_sha256sum_txt=$(url "${RELEASE_DOWNLOAD_BASE_URL}/sha256sum.txt")

    local TEMP_DIR=$(mktemp -d -t "check-ollama-${OLLAMA_VERSION}-${file}-XXXXXX")
    trap 'rm -rf "${TEMP_DIR}"' RETURN INT TERM

    hash=$(curl -sSL "${url_sha256sum_txt}" | tee "${TEMP_DIR}/sha256sum.txt" | grep -E "\s+\./${file}" | head -n 1 | sed -E 's/\s.+//g')
    if [ $? -ne 0 ] || [ -z "$hash" ]; then
        echo "❌ ERRO: O hash SHA256 do arquivo '${file}' não encontrado no 'sha256sum.txt' da release! Parando instalação." >&2
        return 1
    fi
    if [ "$(curl -sSL "${url}" | tee "${TEMP_DIR}/${file}" | sha256sum | awk '{print $1}')" = "${hash}" ]; then
        return 0
    else
        echo "❌ ERRO: O hash SHA256 do arquivo '${file}' não bate! Parando instalação." >&2
        return 1
    fi
}

checksum 'install.sh' "$CHECKSUM_INSTALL_SH" || exit $?
checksum 'sha256sum.txt' "$CHECKSUM_SHA256SUM_TXT" || exit $?
checksum-from-release 'install.sh' || exit $?

curl -fsSL "$(url "$INSTALL_SH_URL")" | \
    sed -E "s#^(VER_PARAM=\")[^\"]+(\")\$#\1\2\nRELEASE_DOWNLOAD_BASE_URL=\"${RELEASE_DOWNLOAD_BASE_URL}\"#g" | \
    sed -E 's#(DOWNLOAD_URL=")https://ollama.com/download/Ollama-darwin.zip\$\{VER_PARAM\}(")#\1${RELEASE_DOWNLOAD_BASE_URL}/Ollama-darwin.zip\2#g' | \
    sed -E 's#(download_and_extract ")https://ollama.com/download(")#\1${RELEASE_DOWNLOAD_BASE_URL}\2#g' | \
    sh
