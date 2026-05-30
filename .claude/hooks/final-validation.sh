#!/usr/bin/env bash
# final-validation.sh -- hook Stop (equivalente bash de final-validation.ps1)
# Ejecuta la suite completa de tests y registra el resultado en .specify/progress.md

set -u

INPUT_JSON="$(cat || true)"

# Evitar bucle infinito de hooks Stop
stop_active=""
if command -v jq >/dev/null 2>&1; then
    stop_active=$(printf '%s' "$INPUT_JSON" | jq -r '.stop_hook_active // empty' 2>/dev/null || true)
fi
[ "$stop_active" = "true" ] && exit 0

timestamp=$(date '+%Y-%m-%d %H:%M:%S')
report_file=".specify/progress.md"
mkdir -p .specify

if [ ! -f "$report_file" ]; then
    {
        echo "# Progreso de validación"
        echo ""
        echo "Log acumulado generado por el hook final-validation."
    } > "$report_file"
fi

{
    echo ""
    echo "## Validación: $timestamp"
} >> "$report_file"

PY=""
command -v python  >/dev/null 2>&1 && PY=python
[ -z "$PY" ] && command -v python3 >/dev/null 2>&1 && PY=python3
if [ -z "$PY" ]; then
    echo "Python no disponible: validación omitida." >> "$report_file"
    exit 0
fi

tests_path=""
for pattern in "tests" "*/tests" "src/*/tests"; do
    for hit in $pattern; do
        if [ -d "$hit" ]; then
            tests_path="$hit"
            break 2
        fi
    done
done
if [ -z "$tests_path" ]; then
    echo "Sin tests todavía." >> "$report_file"
    exit 0
fi

result=$("$PY" -m pytest "$tests_path" --tb=short 2>&1)
exit_code=$?

{
    echo '```'
    echo "$result"
    echo '```'
} >> "$report_file"

if [ "$exit_code" -eq 1 ]; then
    printf '\033[31mHay tests fallando. El agente debe corregirlos antes de terminar.\033[0m\n'
    exit 2
fi
exit 0
