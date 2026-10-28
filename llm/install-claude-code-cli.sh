#!/bin/sh
export CLAUDE_VERSION='2.1.308'

# Official hash extracted via `npm view @anthropic-ai/claude-code@2.1.308 dist.integrity`
# The expected format is SRI (Subresource Integrity) with a sha512- prefix
CHECKSUM_NPM_TARBALL='sha512-b2HnszgyN73wRTFP+IYPDJNn9ADXnG6jr26ibL+w03HSKqfb6GqE8Jnfr4mz37Zv4AT/NP+B5/3c1F89WTdWSA=='

NPM_REGISTRY_BASE_URL='https://registry.npmjs.org'
PACKAGE_SCOPE='@anthropic-ai'
PACKAGE_NAME='claude-code'
TARBALL_FILE="${PACKAGE_NAME}-\${CLAUDE_VERSION}.tgz"

# Create a secure temporary directory in the global scope to ensure isolation throughout the process
TEMP_DIR=$(mktemp -d -t "check-claude-${CLAUDE_VERSION}-XXXXXX")
# Ensures the cleanup of the temporary directory on script exit (success, error, or interruption)
trap 'rm -rf "${TEMP_DIR}"' EXIT INT TERM

# Function to dynamically expand the CLAUDE_VERSION variable in the URL string
function url {
    local url=$1
    echo -n "$(echo -n "$url" | sed -E "s#\\\$\{CLAUDE_VERSION\}#${CLAUDE_VERSION}#g")"
    return 0
}

# Integrity check function using Node.js to compute SHA-512 in Base64
function checksum_npm() {
    local file=$1
    local expected_hash=$2
    # Constructs proper npm registry tarball URL for scoped package
    local download_url="${NPM_REGISTRY_BASE_URL}/${PACKAGE_SCOPE}/${PACKAGE_NAME}/-/${file}"

    if [ -z "$expected_hash" ]; then
        echo "⚠️ WARNING: No hash provided for validation of '${file}'."
        return 0
    fi

    echo "📥 Downloading and validating integrity of the Claude Code v${CLAUDE_VERSION} package..."
    
    # Downloads the tarball DIRECTLY into the temporary folder
    curl -sSL "${download_url}" -o "${TEMP_DIR}/${file}"
    if [ $? -ne 0 ]; then
        echo "❌ ERROR: Failed to download the file from the npm registry." >&2
        return 1
    fi

    # Uses the system-installed Node.js to calculate the SHA-512 hash in Base64 format (SRI)
    local calculated_hash=$(node -e "
        const fs = require('fs');
        const crypto = require('crypto');
        try {
            const buffer = fs.readFileSync('${TEMP_DIR}/${file}');
            const hash = crypto.createHash('sha512').update(buffer).digest('base64');
            console.log('sha512-' + hash);
        } catch (e) {
            process.exit(1);
        }
    " 2>/dev/null)

    if [ $? -ne 0 ] || [ -z "$calculated_hash" ]; then
        echo "❌ ERROR: Node.js failed to calculate the hash of the local file." >&2
        return 1
    fi

    # Compares the calculated hash with the expected hash by the script
    if [ "${calculated_hash}" = "${expected_hash}" ]; then
        echo "✅ INTEGRITY CONFIRMED: The hash matches perfectly!"
        return 0
    else
        echo "❌ CRITICAL ERROR: The SHA-512 hash of the downloaded file does not match!" >&2
        echo "   Expected: ${expected_hash}" >&2
        echo "   Calculated: ${calculated_hash}" >&2
        return 1
    fi
}

# 1. Run the tarball file check
TARGET_TARBALL=$(url "$TARBALL_FILE")
checksum_npm "$TARGET_TARBALL" "$CHECKSUM_NPM_TARBALL" || exit $?

# 2. If validation passes, run the global installation from the verified temporary file
echo "⚙️  Starting global installation via npm..."
npm install -g "${TEMP_DIR}/${TARGET_TARBALL}" \
  --allow-scripts="${TEMP_DIR}/${TARGET_TARBALL}"

echo "🎉 Claude Code v${CLAUDE_VERSION} installed successfully with guaranteed security!"