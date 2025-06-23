# http_app

Esta es una aplicación HTTP sencilla construida con Flask en Python. Expone un endpoint `/health` que responde con `"OK"`, útil para pruebas de salud y monitoreo.

## Estructura

- `app.py`: Código fuente principal de la aplicación Flask.
- `Dockerfile`: Imagen Docker para contenerizar la aplicación.
- `docker-compose.yml`: Orquestación de la aplicación junto a `node-exporter` para métricas.
- `test_health.py`: Test unitario para el endpoint `/health`.

## Uso

### 1. Ejecutar localmente

```bash
pip install flask
python app.py
```

La aplicación estará disponible en `http://localhost:5000/health`.

### 2. Ejecutar con Docker

Construir la imagen Docker:

```bash
docker build -t http_app .
```

Ejecutar el contenedor:

```bash
docker run -p 8080:8080 http_app
```

### 3. Usar docker-compose

Levantar los servicios (aplicación + node-exporter):

```bash
docker-compose up
```

Esto expondrá la aplicación en `http://localhost:8080/health` y las métricas de node-exporter en el puerto 9100.

## Pruebas

Para ejecutar el test unitario:

```bash
python test_health.py
```

## Métricas

Se incluye `node-exporter` en el `docker-compose.yml` para exponer métricas del sistema, facilitando la integración con Prometheus y Grafana.

## Notas

- Se eligió `node-exporter` por ser más ligero y sencillo que `cadvisor`.
- El endpoint `/health` responde siempre `"OK"` para facilitar pruebas