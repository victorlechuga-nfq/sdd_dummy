param(
    [Parameter(ValueFromPipeline=$true)]
    [string]$InputJson
)

if (-not $InputJson) {
    $InputJson = [Console]::In.ReadToEnd()
}

$filePath = ""
try {
    $parsed = $InputJson | ConvertFrom-Json -ErrorAction Stop
    if ($parsed.tool_input.file_path) {
        $filePath = $parsed.tool_input.file_path
    } elseif ($parsed.tool_input.path) {
        $filePath = $parsed.tool_input.path
    }
} catch {
    $filePath = ""
}

if ([string]::IsNullOrWhiteSpace($filePath) -or -not (Test-Path $filePath)) {
    exit 0
}

$ext = [System.IO.Path]::GetExtension($filePath).TrimStart('.').ToLower()

$isJsTs  = $ext -in @('js','ts','jsx','tsx')
$isWeb   = $ext -in @('js','ts','jsx','tsx','json','css','html')

if ($isWeb) {
    if (Get-Command npx -ErrorAction SilentlyContinue) {
        npx prettier --write "$filePath" 2>$null
    }
    if ($isJsTs -and (Get-Command npx -ErrorAction SilentlyContinue)) {
        npx eslint --fix "$filePath" 2>$null
    }
}

if ($ext -eq 'py') {
    if (Get-Command ruff -ErrorAction SilentlyContinue) {
        ruff check --fix "$filePath" 2>$null
        ruff format "$filePath" 2>$null
    } elseif (Get-Command black -ErrorAction SilentlyContinue) {
        black "$filePath" 2>$null
    }
}

if ($ext -eq 'go') {
    if (Get-Command gofmt -ErrorAction SilentlyContinue) {
        gofmt -w "$filePath" 2>$null
    }
}