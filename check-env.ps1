# check-env.ps1
Write-Host "==============================" -ForegroundColor Cyan
Write-Host " Verificacion del entorno SDD " -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan

function Check-Tool {
    param($Name, $Command)
    try {
        $result = Invoke-Expression $Command 2>&1 | Select-Object -First 1
        if ($LASTEXITCODE -eq 0 -or $result) {
            Write-Host "OK $Name`: $result" -ForegroundColor Green
        } else {
            Write-Host "FAIL $Name`: NO ENCONTRADO" -ForegroundColor Red
        }
    } catch {
        Write-Host "FAIL $Name`: NO ENCONTRADO -- $_" -ForegroundColor Red
    }
}

Check-Tool "Git"          "git --version"
#Check-Tool "Node.js"      "node --version"
#Check-Tool "npm"          "npm --version"
Check-Tool "Python"       "python --version"
Check-Tool "uv"           "uv --version"
Check-Tool "jq"           "jq --version"
Check-Tool "Claude Code"  "claude --version"
Check-Tool "Specify CLI"  "specify version"

Write-Host ""
Write-Host "--- Test funcional de jq ---" -ForegroundColor Cyan
$jqInput = '{"tool_input":{"file_path":"/test.py"}}'
$jqResult = $jqInput | jq -r '.tool_input.file_path' 2>&1
if ($jqResult -eq "/test.py") {
    Write-Host "OK jq funciona correctamente" -ForegroundColor Green
} else {
    Write-Host "FAIL jq no parsea JSON -- resultado: $jqResult" -ForegroundColor Red
}

Write-Host ""
Write-Host "--- Test de autenticacion Claude ---" -ForegroundColor Cyan
$claudeResult = claude -p "responde solo: OK" 2>&1
if ($claudeResult -match "OK") {
    Write-Host "OK Claude Code autenticado" -ForegroundColor Green
} else {
    Write-Host "FAIL Claude Code sin autenticar -- ejecuta: claude login" -ForegroundColor Red
}

Write-Host "==============================" -ForegroundColor Cyan