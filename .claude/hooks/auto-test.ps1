# auto-test.ps1  --  hook PostToolUse
# Ejecuta los tests unitarios tras cada edicion de codigo Python.
# PORTABLE: opera sobre el directorio del proyecto (cwd). Sin rutas absolutas.
param(
    [Parameter(ValueFromPipeline=$true)]
    [string]$InputJson
)

if (-not $InputJson) { $InputJson = [Console]::In.ReadToEnd() }

$filePath = ""
try {
    $parsed = $InputJson | ConvertFrom-Json -ErrorAction Stop
    if ($parsed.tool_input.file_path) { $filePath = $parsed.tool_input.file_path }
    elseif ($parsed.tool_input.path)  { $filePath = $parsed.tool_input.path }
} catch { $filePath = "" }

# Solo actuar sobre ficheros .py
if ([string]::IsNullOrWhiteSpace($filePath) -or -not ($filePath -like "*.py")) { exit 0 }

# No relanzar tests si se esta editando un test (evita bucle de feedback)
if ($filePath -like "*\tests\*" -or $filePath -like "*/tests/*") { exit 0 }

# Resolver el interprete de Python
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command python3 -ErrorAction SilentlyContinue }
if (-not $python) { exit 0 }

# Resolver el directorio de tests unitarios de forma portable.
# Orden: tests/unit  ->  <paquete>/tests/unit  ->  src/<paquete>/tests/unit  ->  tests
$unitPath = $null
foreach ($p in @("tests/unit", "*/tests/unit", "src/*/tests/unit", "tests", "*/tests")) {
    $hit = Get-Item -Path $p -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($hit) { $unitPath = $hit.FullName; break }
}
if (-not $unitPath) { exit 0 }   # aun no hay tests (TDD muy temprano): no bloquear

$output   = & $python.Source -m pytest $unitPath -x -q --no-header -p no:cacheprovider 2>&1
$exitCode = $LASTEXITCODE

# Codigos pytest: 0=ok, 1=fallos, 5=sin tests recogidos.
# Solo bloqueamos (exit 2) ante fallos reales de test (codigo 1);
# el resto no debe frenar al agente por problemas de infraestructura.
if ($exitCode -eq 1) {
    Write-Host "TESTS FALLANDO - corrige antes de continuar:" -ForegroundColor Red
    $output | ForEach-Object { Write-Host $_ -ForegroundColor Red }
    exit 2
}
exit 0
