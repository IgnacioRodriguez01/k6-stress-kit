# Solicita el nombre del test al usuario
$testName = Read-Host "Ingrese el nombre de los tests"

# Obtiene la fecha actual en diferentes formatos
$today = Get-Date -Format "yyyy-MM-dd"
$dateTime = Get-Date -Format "yyyyMMdd_HHmmss"

# Define la carpeta de exportación y la crea si no existe
$exportFolder = ".\$today"
if (!(Test-Path $exportFolder)) {
    New-Item -ItemType Directory -Path $exportFolder | Out-Null
}

# Ruta completa del archivo de exportación
$exportFile = "$exportFolder\$testName`_$dateTime.html"

# Definir variables de entorno directamente en el script
$envVars = @{
    "K6_PROMETHEUS_RW_TREND_AS_NATIVE_HISTOGRAM" = "false"
    "K6_PROMETHEUS_RW_SERVER_URL" = "http://localhost:9090/api/v1/write"
    "K6_PROMETHEUS_RW_TREND_STATS" = "p(95),p(99),min,max"
    "K6_PROMETHEUS_RW_PUSH_INTERVAL" = "2s"
    "TEST_NAME" = $testName
}

# Aplicar las variables de entorno
$envVars.GetEnumerator() | ForEach-Object {
    Set-Item -Path "Env:$($_.Key)" -Value $_.Value
}

# Abre el dashboard de grafana
# Start-Process chrome.exe '--new-window https://www.google.com'

# Ejecuta el test de K6
Write-Host "Ejecutando K6 con el test: $testName..."
k6 run --out experimental-prometheus-rw k6.js
