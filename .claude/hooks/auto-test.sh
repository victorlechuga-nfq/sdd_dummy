#!/usr/bin/env bash
# auto-test.sh -- hook PostToolUse (equivalente bash de auto-test.ps1)
# Ejecuta los tests unitarios tras cada edición de código Python.

set -u

INPUT_JSON="$(cat || true)"
file_path=""
if command -v jq >/dev/null 2>&1; then
    file_path=$(printf '%s' "$INPUT_JSON" | jq -r '.tool_input.file_path // .tool_input.path // empty' 2>/dev/null || true)
else
    file_path=$(printf '%s' "$INPUT_JSON" | grep -oE '"(file_path|path)"\s*:\s*"[^"]+"' | head -1 | sed -E 's/.*:\s*"([^"]+)"/\1/')
fi

# Solo actuar sobre ficheros .py
case "$file_path" in
    *.py) ;;
    *) exit 0 ;;
esac

# No relanzar tests si se está editando un test (evita bucle)
case "$file_path" in
    */tests/*) exit 0 ;;
esac

# Resolver el intérprete de Python
PY=""
command -v python  >/dev/null 2>&1 && PY=python
[ -z "$PY" ] && command -v python3 >/dev/null 2>&1 && PY=python3
[ -z "$PY" ] && exit 0

# Resolver el directorio de tests unitarios de forma portable
unit_path=""
for pattern in "tests/unit" "*/tests/unit" "src/*/tests/unit" "tests" "*/tests"; do
    for hit in $pattern; do
        if [ -d "$hit" ]; then
            unit_path="$hit"
            break 2
        fi
    done
done
[ -z "$unit_path" ] && exit 0

output=$("$PY" -m pytest "$unit_path" -x -q --no-header -p no:cacheprovider 2>&1)
exit_code=$?

# pytest codes: 0=ok, 1=fallos, 5=sin tests recogidos
if [ "$exit_code" -eq 1 ]; then
    printf '\033[31mTESTS FALLANDO - corrige antes de continuar:\033[0m\n'
    printf '%s\n' "$output"
    exit 2
fi
exit 0
