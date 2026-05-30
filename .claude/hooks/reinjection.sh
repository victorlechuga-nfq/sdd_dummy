#!/usr/bin/env bash
# reinjection.sh -- hook SessionStart (equivalente bash de reinjection.ps1)
# Re-inyecta el contexto base del proyecto al iniciar sesión.

set -u

echo "=== CONTEXTO REINYECTADO ==="

# 1. Spec original del proyecto (raíz del repo).
echo ""
echo "--- Spec del proyecto ---"
spec_file=""
if [ -f "spec_pr.md" ]; then
    spec_file="spec_pr.md"
fi
if [ -z "$spec_file" ]; then
    for cand in spec*.md; do
        [ -f "$cand" ] || continue
        [ "$cand" = "spec-template.md" ] && continue
        spec_file="$cand"
        break
    done
fi
[ -z "$spec_file" ] && [ -f "spec.md" ] && spec_file="spec.md"

if [ -n "$spec_file" ]; then
    echo "($spec_file)"
    head -n 120 "$spec_file"
else
    echo "(spec del proyecto no encontrada en la raíz del repo)"
fi

# 2. Constitution (principios y guardarrailes).
echo ""
echo "--- Constitution (principios) ---"
if [ -f ".specify/memory/constitution.md" ]; then
    cat ".specify/memory/constitution.md"
else
    echo "(.specify/memory/constitution.md no encontrado)"
fi

# 3. Context (decisiones tomadas y ADRs vivos).
echo ""
echo "--- Context (decisiones / ADRs) ---"
if [ -f ".specify/memory/context.md" ]; then
    head -n 80 ".specify/memory/context.md"
else
    echo "(.specify/memory/context.md no encontrado)"
fi
echo "=== FIN DE CONTEXTO ==="
