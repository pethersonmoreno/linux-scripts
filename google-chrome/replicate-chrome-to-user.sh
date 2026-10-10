#!/usr/bin/env bash
#
# replicate-chrome-to-user.sh - Replica as configurações do Google Chrome de um usuário para outro.
#
# Uso: sudo ./replicate-chrome-to-user.sh <usuario_origem> <usuario_destino>

# 1. Exige privilégios de root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Erro: Este script precisa ser executado como root ou com 'sudo'."
    exit 1
fi

# 2. Valida argumentos
if [ "$#" -ne 2 ]; then
    echo "❌ Erro: Argumentos inválidos. Use: sudo $0 <usuario_origem> <usuario_destino>"
    exit 1
fi

SRC_USER="$1"
DST_USER="$2"

# 3. Valida se o usuário de origem existe no sistema
if ! id "$SRC_USER" &>/dev/null; then
    echo "❌ Erro: O usuário de origem '$SRC_USER' não existe no sistema."
    exit 1
fi

# Valida se o usuário de destino existe no sistema
if ! id "$DST_USER" &>/dev/null; then
    echo "❌ Erro: O usuário de destino '$DST_USER' não existe no sistema."
    exit 1
fi

# 4. Validação para garantir que o Chrome não está ativo para origem ou destino
for usr in "$SRC_USER" "$DST_USER"; do
    if [ $(ps -u "$usr" -o comm= | grep -E '^chrome$' | wc -l) -gt 0 ]; then
        >&2 echo "❌ Erro: O usuário $usr deve fechar o chrome completamente antes de executar esse procedimento!"
        exit 1
    fi
done

SRC_HOME="/home/$SRC_USER"
DST_HOME="/home/$DST_USER"
CONFIG_DIRS=(
    ".config/google"
    ".config/google-chrome"
    ".cache/google-chrome"
)

# Recupera o ID do grupo principal (GID) do usuário de destino de forma dinâmica
DST_GID=$(id -g "$DST_USER")

echo "🔄 Iniciando a replicação da configuração do Google Chrome de $SRC_USER para $DST_USER..."

# 5. Replica cada diretório
for dir in "${CONFIG_DIRS[@]}"; do
    SRC_DIR="$SRC_HOME/$dir"
    DST_DIR="$DST_HOME/$dir"
    DST_PARENT=$(dirname "$DST_DIR")

    if [ -d "$SRC_DIR" ]; then
        
        [ ! -d "$DST_PARENT" ] && mkdir -p "$DST_PARENT" && chown "$DST_USER:$DST_GID" "$DST_PARENT"

        [ -d "$DST_DIR" ] && rm -rf "$DST_DIR"
        cp -r "$SRC_DIR" "$DST_PARENT/"
    fi
done

# 6. Limpa arquivos de trava Singleton
DST_CHROME_CONFIG="$DST_HOME/.config/google-chrome"
if [ -d "$DST_CHROME_CONFIG" ]; then
    rm -f "$DST_CHROME_CONFIG"/Singleton*
fi

# 7. Corrige permissões usando o UID do usuário e o GID dinâmico obtido
for dir in "${CONFIG_DIRS[@]}"; do
    DST_DIR="$DST_HOME/$dir"
    [ -d "$DST_DIR" ] && chown -R "$DST_USER:$DST_GID" "$DST_DIR"
done

echo "✅ Perfil do Chrome duplicado com sucesso!"
