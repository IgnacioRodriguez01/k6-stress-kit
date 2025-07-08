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
    "K6_WEB_DASHBOARD"       = "true"
    "K6_WEB_DASHBOARD_HOST"  = "localhost"
    "K6_WEB_DASHBOARD_PORT"  = "5665"
    "K6_WEB_DASHBOARD_PERIOD"= "2s"
    "K6_WEB_DASHBOARD_OPEN"  = "true"
    "K6_WEB_DASHBOARD_EXPORT" = $exportFile
    "TEST_NAME" = $testName
}

# Aplicar las variables de entorno
$envVars.GetEnumerator() | ForEach-Object {
    Set-Item -Path "Env:$($_.Key)" -Value $_.Value
}

# Ejecuta el test de K6
Write-Host "Ejecutando K6 con el test: $testName..."
k6 run k6.js
