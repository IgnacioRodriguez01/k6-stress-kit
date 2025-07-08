#!/bin/zsh

# Script para ejecutar una vuelta de k6, abriendo el dashboard de K6, y exportando
# una captura interactiva de sus resultados hacia el directorio actual.

# Solicita el nombre del test
read "testName?Ingrese el nombre de los tests: "

# Fecha actual
today=$(date +%F)
dateTime=$(date +%Y%m%d_%H%M%S)

# Crear carpeta de exportación si no existe
exportFolder="./$today"
mkdir -p "$exportFolder"

# Ruta del archivo exportado
exportFile="$exportFolder/${testName}_${dateTime}.html"

# Variables de entorno para K6 Dashboard
export K6_WEB_DASHBOARD=true
export K6_WEB_DASHBOARD_HOST=localhost
export K6_WEB_DASHBOARD_PORT=5665
export K6_WEB_DASHBOARD_PERIOD=2s
export K6_WEB_DASHBOARD_OPEN=true
export K6_WEB_DASHBOARD_EXPORT="$exportFile"
export TEST_NAME="$testName"

# Ejecutar el test
echo "Ejecutando K6 con el test: $testName..."
k6 run k6.js
