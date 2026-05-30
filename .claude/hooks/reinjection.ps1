# reinjection.ps1  --  hook SessionStart
# Re-inyecta el contexto base del proyecto al iniciar sesion o tras compactacion:
# la spec original + la constitution + el context (decisiones/ADRs).
# PORTABLE: opera sobre el directorio del proyecto (cwd). Sin rutas absolutas.
Write-Host "=== CONTEXTO REINYECTADO ==="

# 1. Spec original del proyecto (raiz del repo).
#    Canonico: spec_pr.md  ->  cualquier spec*.md  ->  spec.md
Write-Host ""
Write-Host "--- Spec del proyecto ---"
$specFile = $null
if (Test-Path "spec_pr.md") { $specFile = "spec_pr.md" }
if (-not $specFile) {
    $cand = Get-ChildItem -Path . -Filter "spec*.md" -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -ne "spec-template.md" } | Select-Object -First 1
    if ($cand) { $specFile = $cand.Name }
}
if (-not $specFile -and (Test-Path "spec.md")) { $specFile = "spec.md" }
if ($specFile) {
    Write-Host "($specFile)"
    Get-Content $specFile -TotalCount 120
} else {
    Write-Host "(spec del proyecto no encontrada en la raiz del repo)"
}

# 2. Constitution (principios y guardarrailes).
Write-Host ""
Write-Host "--- Constitution (principios) ---"
if (Test-Path ".specify/memory/constitution.md") {
    Get-Content ".specify/memory/constitution.md"
} else {
    Write-Host "(.specify/memory/constitution.md no encontrado)"
}

# 3. Context (decisiones tomadas y ADRs vivos).
Write-Host ""
Write-Host "--- Context (decisiones / ADRs) ---"
if (Test-Path ".specify/memory/context.md") {
    Get-Content ".specify/memory/context.md" -TotalCount 80
} else {
    Write-Host "(.specify/memory/context.md no encontrado)"
}
Write-Host "=== FIN DE CONTEXTO ==="
