.PHONY: up down test cleanup

up:
	docker compose --profile staging pull && \
	docker compose --profile staging up -d

down:
	docker compose --profile staging down

test:
	docker run -d -p 8080:8080 --name my-app leticiavalladares/test:latest && \
	sleep 5 && STATUS=$$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health) && \
	if [ "$$STATUS" -eq 200 ]; then  \
		echo "OK"; \
	else \
		echo "Failed with status $$STATUS"; \
		exit 1 ; \
	fi

cleanup:
	docker stop my-app && \
	docker rm my-app

unittest:
	docker build -f test/http_app/Dockerfile -t my-app:test . && \
	docker run --rm my-app:test pytest tests/