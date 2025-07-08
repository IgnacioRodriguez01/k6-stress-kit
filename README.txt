### COMPOSE

docker-compose build --no-cache 

docker-compose up --build -d 

### GRAFANA

Importar dashboard k6 Prometheus-dashboard en Grafana
y configurar Prometheus como data source.
En el dashboard, colocar el ID del contenedor del servicio a utilizar en el campo
Container ID.

### RUN TESTS

Modificar k6.js, y luego:

.\run_test_html
o
.\run_test_grafana

### UIs

http://localhost:3000/ GRAFANA (login admin-admin)
http://localhost:9091/containers/ CADVISOR
http://localhost:9090/targets PROMETHEUS



# Es posible que para conseguir los resultados esperados, haya que bajar los recursos normalmente asignados a los contenedores por probar.

# Para su completo funcionamiento, se espera que la API a probar sea un contenedor de Docker en la misma máquina. Esto hace que cAdvisor pueda obtener información de recursos utilizados.
Se pueden realizar pruebas sin cumplir esta condición, pero no se tendrán estas métricas.

# Nota: Postman Runner 20VU ~= k6 25VU