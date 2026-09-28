#!/usr/bin/env bash
#
# Instala as skills nativas do Software Engineering Agent no Gemini CLI / Antigravity.
# Copia as skills de .agents/skills/ para o diretorio global (~/.gemini/config/skills/).
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SOURCE_SKILLS_DIR="$REPO_ROOT/.agents/skills"
TARGET_DIR="$HOME/.gemini/config/skills"
FORCE=false

if [[ "${1:-}" == "--force" || "${1:-}" == "-f" ]]; then
    FORCE=true
fi

if [[ ! -d "$SOURCE_SKILLS_DIR" ]]; then
    echo "Erro: Diretorio de skills nao encontrado: $SOURCE_SKILLS_DIR" >&2
    exit 1
fi

mkdir -p "$TARGET_DIR"

echo "Instalando skills nativas no Gemini CLI..."
echo "Origem : $SOURCE_SKILLS_DIR"
echo "Destino: $TARGET_DIR"
echo ""

installed_count=0

for skill_dir in "$SOURCE_SKILLS_DIR"/*; do
    if [[ -d "$skill_dir" ]]; then
        skill_name="$(basename "$skill_dir")"
        dest_skill_path="$TARGET_DIR/$skill_name"

        if [[ -d "$dest_skill_path" ]]; then
            if [[ "$FORCE" == true ]]; then
                rm -rf "$dest_skill_path"
                cp -r "$skill_dir" "$dest_skill_path"
                echo " [ATUALIZADO] /$skill_name -> $dest_skill_path"
                installed_count=$((installed_count + 1))
            else
                echo " [IGNORADO]   /$skill_name ja existe. Use --force para sobrescrever."
            fi
        else
            cp -r "$skill_dir" "$dest_skill_path"
            echo " [INSTALADO]  /$skill_name -> $dest_skill_path"
            installed_count=$((installed_count + 1))
        fi
    fi
done

echo ""
echo "Concluido: $installed_count skills registradas com sucesso."
echo "Comandos disponiveis no CLI: /audit, /sdd, /review, /analyze, /architect, /security, /test, /performance, /refactor"
