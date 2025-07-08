#!/bin/zsh

# Script para ejecutar una vuelta de k6, exportando métricas hacia prometheus, para 
# poder tomarlas desde Grafana.

# Solicita el nombre del test al usuario
read "testName?Ingrese el nombre de los tests: "

# Fecha actual
today=$(date +%F)
dateTime=$(date +%Y%m%d_%H%M%S)

# Variables de entorno
export K6_PROMETHEUS_RW_TREND_AS_NATIVE_HISTOGRAM=false
export K6_PROMETHEUS_RW_SERVER_URL="http://localhost:9090/api/v1/write"
export K6_PROMETHEUS_RW_TREND_STATS="p(95),p(99),min,max"
export K6_PROMETHEUS_RW_PUSH_INTERVAL="2s"
export TEST_NAME="$testName"

# Ejecutar el test de k6
echo "Ejecutando K6 con el test: $testName..."
k6 run --out experimental-prometheus-rw k6.js
