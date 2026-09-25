#!/usr/bin/env bash
# ==============================================================================
# Configuração Dinâmica do Cérebro do Agente (BRAIN) com o Cofre do Obsidian (Linux/macOS)
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BRAIN_DIR="$PROJECT_ROOT/BRAIN"
ENV_FILE="$PROJECT_ROOT/.env"

echo "============================================================"
echo "  SE-OS: Configuração Dinâmica do Cofre do Obsidian (BRAIN)"
echo "============================================================"

VAULT_PATH="$1"

if [ -z "$VAULT_PATH" ] && [ -f "$ENV_FILE" ]; then
    VAULT_PATH=$(grep -E '^OBSIDIAN_VAULT_PATH=' "$ENV_FILE" | cut -d '=' -f2- | tr -d '"' | tr -d "'")
fi

if [ -z "$VAULT_PATH" ] || [[ "$VAULT_PATH" == *"SeuUsuario"* ]]; then
    read -p "Digite o caminho completo do seu Cofre do Obsidian: " VAULT_PATH
fi

# Expand ~ to $HOME
VAULT_PATH="${VAULT_PATH/#\~/$HOME}"

if [ ! -d "$VAULT_PATH" ]; then
    read -p "O diretório '$VAULT_PATH' não existe. Deseja criá-lo agora? (s/n): " confirm
    if [[ "$confirm" =~ ^[sSyY] ]]; then
        mkdir -p "$VAULT_PATH"
        echo "-> Cofre criado em: $VAULT_PATH"
    else
        echo "Operação abortada."
        exit 1
    fi
fi

if [ -L "$BRAIN_DIR" ]; then
    echo "-> Removendo symlink anterior do BRAIN..."
    rm "$BRAIN_DIR"
elif [ -d "$BRAIN_DIR" ]; then
    echo "-> Movendo pasta BRAIN física para backup..."
    mv "$BRAIN_DIR" "${BRAIN_DIR}.bak"
fi

ln -s "$VAULT_PATH" "$BRAIN_DIR"

echo ""
echo "✅ SUCESSO: Symlink estabelecido: $BRAIN_DIR -> $VAULT_PATH"
