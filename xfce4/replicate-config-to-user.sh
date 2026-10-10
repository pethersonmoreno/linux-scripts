#!/usr/bin/env bash
#
# replicate-config-to-user.sh - Replicar configurações do XFCE4 de um usuário para outro.
# 
# Uso: sudo ./replicate-config-to-user.sh <usuario_origem> <usuario_destino>

# 1. Verifica se o script está sendo executado como root (necessário para gerenciar pastas de outros usuários)
if [ "$EUID" -ne 0 ]; then
    echo "❌ Erro: Este script precisa ser executado como root ou com 'sudo'."
    echo "Uso: sudo $0 <usuario_origem> <usuario_destino>"
    exit 1
fi

# 2. Verifica se o número correto de argumentos foi passado
if [ "$#" -ne 2 ]; then
    echo "❌ Erro: Argumentos inválidos."
    echo "Uso: sudo $0 <usuario_origem> <usuario_destino>"
    exit 1
fi

SRC_USER="$1"
DST_USER="$2"

# 3. Valida se o usuário de origem existe no sistema
if ! id "$SRC_USER" &>/dev/null; then
    echo "❌ Erro: O usuário de origem '$SRC_USER' não existe no sistema."
    exit 1
fi

# 4. Valida se o usuário de destino existe no sistema
if ! id "$DST_USER" &>/dev/null; then
    echo "❌ Erro: O usuário de destino '$DST_USER' não existe no sistema."
    exit 1
fi

# Recupera o ID do grupo principal (GID) do usuário de destino de forma dinâmica
DST_GID=$(id -g "$DST_USER")

# Definição dos caminhos das pastas de configuração
SRC_XFCE_DIR="/home/$SRC_USER/.config/xfce4"
DST_CONFIG_DIR="/home/$DST_USER/.config"
DST_XFCE_DIR="$DST_CONFIG_DIR/xfce4"

# 5. Verifica se o usuário de origem realmente possui uma configuração do XFCE4
if [ ! -d "$SRC_XFCE_DIR" ]; then
    echo "❌ Erro: A pasta de configuração '$SRC_XFCE_DIR' não foi encontrada."
    exit 1
fi

echo "🔄 Iniciando a replicação da configuração do XFCE4..."
echo "👤 Origem:  $SRC_USER"
echo "👤 Destino: $DST_USER"

# 6. Cria a pasta .config no destino caso ela não exista (garantia para novos usuários)
if [ ! -d "$DST_CONFIG_DIR" ]; then
    mkdir -p "$DST_CONFIG_DIR"
fi

# 7. Backup da configuração antiga do destino (caso exista), para segurança
if [ -d "$DST_XFCE_DIR" ]; then
    BACKUP_DIR="${DST_XFCE_DIR}_backup_$(date +%Y%m%d_%H%M%S)"
    echo "⚠️  Aviso: Configuração existente no destino encontrada. Movendo para $BACKUP_DIR"
    mv "$DST_XFCE_DIR" "$BACKUP_DIR"
fi

# 8. Copia os arquivos de configuração
echo "📂 Copiando os arquivos..."
cp -r "$SRC_XFCE_DIR" "$DST_CONFIG_DIR/"

# 9. Ajusta as permissões de dono e grupo para o usuário de destino
echo "🔒 Ajustando permissões para o usuário '$DST_USER'..."
chown -R "$DST_USER:$DST_GID" "$DST_XFCE_DIR"

echo "✅ Concluído com sucesso!"
echo "💡 Nota: Se o usuário '$DST_USER' estiver logado, ele precisará reiniciar o XFCE ou rodar 'xfce4-panel --restart'."
