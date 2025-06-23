Preguntas:

1. ¿Cuál es la diferencia entre Infrastructure as Code (IaC) y Configuration Management?

    La diferencia más importante entre IaC (Infraestructura como Código) y la Gestión de Configuración (CM) es que IaC se utiliza para aprovisionar infraestructura desde cero, mientras que CM se encarga de mantener la infraestructura que ya ha sido creada.

    Generalmente se usan de forma conjunta: IaC se emplea inicialmente para aprovisionar recursos, modificarlos o incluso eliminarlos como por ejemplo, eliminar una subred en una red virtual. CM entra en juego cuando ya contamos con los recursos y queremos, por ejemplo, instalar, actualizar o desinstalar software, o conectar una base de datos con una aplicación a través de un archivo de configuración.

&nbsp;

2. Crea un Dockerfile que sirva una aplicación HTTP sencilla en /health devolviendo "OK".
Debe estar contenido dentro de docker-compose.yml junto a cadvisor o node-exporter.

    Solución en directorio [http_app/](http_app/)

&nbsp;

3. Explica qué hace este manifiesto de Kubernetes:

    ````YAML
    apiVersion: v1
    kind: Service
    metadata:
    name: my-service
    spec:
    selector:
        app: my-app
    ports:
    - port: 80
        targetPort: 8080
    ````

    Este manifiesto crea un servicio (objeto de Kubernetes) llamado `my-service`, que está vinculado a los pods con la etiqueta `app=my-app`. Esos pods pueden ser accedidos a través del puerto 80, y gracias a este servicio el tráfico se enruta al puerto 8080, donde se ejecuta la aplicación. La idea de un "Service" en Kubernetes es exponer un punto de acceso para que los clientes puedan conectarse a determinados pods.

&nbsp;

4. Escribe un pipeline que:
- Haga build de un contenedor
- Ejecute tests simulados (echo OK)
- Haga push (simulado o real) a un registry local
- Despliegue en staging (usando docker-compose)

    Solución en [.github/workloads/staging-deploy.yml](.github/workloads/staging-deploy.yml)

&nbsp;

5. ¿Qué es una SLI y cómo se relaciona con un SLO? Propón una alerta realista para una API crítica.

    Un SLI es una métrica para medir el rendimiento de un servicio, por ejemplo: disponibilidad, latencia, confiabilidad, etc. Por otro lado, un SLO es la definición de un objetivo que debe alcanzar el SLI. Si el SLI está por debajo del SLO, eso indica que el servicio necesita mejoras para cumplir con lo esperado.

    Ejemplo real de una alerta crítica:
    Alerta:
    - Medir la latencia (SLI) del punto de acceso "/login" de una determinada aplicación.
    - SLO: El 95 % de las solicitudes al punto de acceso "/login" deben completarse en menos de 300 ms en un período de 30 días.

&nbsp;

6. Tu contenedor Docker reinicia en bucle al hacer docker-compose up. ¿Qué harías para identificar el problema?

    Primero, revisaría los logs con `docker-compose logs`. Ahí buscaría posibles errores relacionados con el enlace de puertos, procesos, archivos faltantes, y similares.

    Segundo, desactivaría la política de reinicio en el `docker-compose.yml` con `docker update --restart=no`, para poder investigar más a fondo dónde ocurre el error y evitar el bucle de reinicios.

    Tercero, ejecutaría el contenedor manualmente con `docker-compose run --rm <servicio>`

&nbsp;

7. Diseña una arquitectura básica en AWS para servir una aplicación web con alta disponibilidad, escalabilidad y bajo coste. Menciona al menos 3 servicios principales que usarías y cómo se conectan.

    Los siguientes recursos que elegí ofrecen alta escalabilidad y alta disponibilidad, son serverless y tienen una opción de pago por uso, lo que evita la necesidad de reservar instancias de cualquier tipo y de pagar planes por adelantado. La mayoría de estos recursos tienen planes gratuitos, que en algunos casos son suficientes para desplegar cargas de trabajo pequeñas.

    Dado que no se especifica que la aplicación web deba contener contenido dinámico, usaría un AWS S3 Bucket para alojarla. Para procesar la lógica de negocio, emplearía una función AWS Lambda, ya que permite utilizar cualquier lenguaje de programación que sea compatible a través de SDK. Y para el almacenamiento de datos, usaría DynamoDB, una opción NoSQL.

    Además de estos tres recursos fundamentales, utilizaría una CDN como AWS CloudFront para que la aplicación web esté disponible en distintos países, y también AWS API Gateway para mantener, asegurar y controlar las llamadas a la API de la aplicación web.

    ![Image](https://github.com/user-attachments/assets/b52cedc5-df4e-41a2-8f6a-8c28b77dd9a6)

&nbsp;

8. ¿Has utilizado Inteligencia Artificial (ChatGPT, Cursor, Claude...)? Si es así, ¿qué prompts has usado?

    Sí, usé Copilot y traduje todas mis respuestas del inglés al español usando IA.
    Mis prompts fueron:
    - Translate into Spanish the following text: ""
    - Create a real-scenario alert for a business-critical API considering SLI and SLO
    - Simulate metrics of a business-critical API by using Prometheus and Grafana
    - Create a Makefike with make up, make down and make test tasks
    - Create unit test in python for the following function: ""


9. Bonus técnico (opcional):
  - Añadir un Makefile con tareas make up, make down, make test.

    [Makefile](Makefile)
&nbsp;
  - Añadir tests unitarios simples (si usa Python o Node).
  
    Test en [http_app/test_health.py](http_app/test_health.py)
&nbsp;
  - Simular métricas de sistema con Prometheus + Grafana.
  
    Pasos a seguir en []()