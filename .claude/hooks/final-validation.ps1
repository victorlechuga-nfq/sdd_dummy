# final-validation.ps1  --  hook Stop
# Al cerrar turno: ejecuta la SUITE COMPLETA de tests (unit + integration + contract)
# y registra el resultado en .specify/progress.md.
# PORTABLE: opera sobre el directorio del proyecto (cwd). Sin rutas absolutas.
param(
    [Parameter(ValueFromPipeline=$true)]
    [string]$InputJson
)

if (-not $InputJson) { $InputJson = [Console]::In.ReadToEnd() }

# Evitar bucle infinito de hooks Stop
$stopActive = $false
try { $stopActive = ($InputJson | ConvertFrom-Json -ErrorAction Stop).stop_hook_active } catch {}
if ($stopActive -eq $true) { exit 0 }

$timestamp  = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$reportFile = ".specify/progress.md"
New-Item -ItemType Directory -Path ".specify" -Force | Out-Null
if (-not (Test-Path $reportFile)) {
    Add-Content -Path $reportFile -Value "# Progreso de validacion"
    Add-Content -Path $reportFile -Value ""
    Add-Content -Path $reportFile -Value "Log acumulado generado por el hook final-validation."
}
Add-Content -Path $reportFile -Value ""
Add-Content -Path $reportFile -Value "## Validacion: $timestamp"

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command python3 -ErrorAction SilentlyContinue }
if (-not $python) {
    Add-Content -Path $reportFile -Value "Python no disponible: validacion omitida."
    exit 0
}

# Resolver la raiz de tests (suite completa) de forma portable.
$testsPath = $null
foreach ($p in @("tests", "*/tests", "src/*/tests")) {
    $hit = Get-Item -Path $p -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($hit) { $testsPath = $hit.FullName; break }
}
if (-not $testsPath) {
    Add-Content -Path $reportFile -Value "Sin tests todavia."
    exit 0
}

$result    = & $python.Source -m pytest $testsPath --tb=short 2>&1
$exitCode  = $LASTEXITCODE
$resultStr = ($result -join [Environment]::NewLine)
Add-Content -Path $reportFile -Value '```'
Add-Content -Path $reportFile -Value $resultStr
Add-Content -Path $reportFile -Value '```'

# exit 2 en un hook Stop devuelve el control al agente para que siga corrigiendo.
if ($exitCode -eq 1) {
    Write-Host "Hay tests fallando. El agente debe corregirlos antes de terminar." -ForegroundColor Red
    exit 2
}
exit 0
