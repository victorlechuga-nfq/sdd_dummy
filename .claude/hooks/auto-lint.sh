#!/usr/bin/env bash
# auto-lint.sh -- hook PostToolUse (equivalente bash de auto-lint.ps1)
# Formatea/lintea el archivo recién editado según su extensión.
# Portable: opera sobre el directorio del proyecto (cwd). Sin rutas absolutas.

set -u

# Leer payload JSON de stdin
INPUT_JSON="$(cat || true)"

# Extraer file_path o path con jq si está disponible, si no con grep
file_path=""
if command -v jq >/dev/null 2>&1; then
    file_path=$(printf '%s' "$INPUT_JSON" | jq -r '.tool_input.file_path // .tool_input.path // empty' 2>/dev/null || true)
else
    file_path=$(printf '%s' "$INPUT_JSON" | grep -oE '"(file_path|path)"\s*:\s*"[^"]+"' | head -1 | sed -E 's/.*:\s*"([^"]+)"/\1/')
fi

[ -z "$file_path" ] && exit 0
[ ! -f "$file_path" ] && exit 0

ext="${file_path##*.}"
ext="${ext,,}"

case "$ext" in
    js|ts|jsx|tsx|json|css|html)
        if command -v npx >/dev/null 2>&1; then
            npx --no-install prettier --write "$file_path" >/dev/null 2>&1 || true
            case "$ext" in
                js|ts|jsx|tsx)
                    npx --no-install eslint --fix "$file_path" >/dev/null 2>&1 || true
                    ;;
            esac
        fi
        ;;
    py)
        if command -v ruff >/dev/null 2>&1; then
            ruff check --fix "$file_path" >/dev/null 2>&1 || true
            ruff format "$file_path" >/dev/null 2>&1 || true
        elif command -v black >/dev/null 2>&1; then
            black "$file_path" >/dev/null 2>&1 || true
        fi
        ;;
    go)
        command -v gofmt >/dev/null 2>&1 && gofmt -w "$file_path" >/dev/null 2>&1 || true
        ;;
esac

exit 0
