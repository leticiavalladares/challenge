.PHONY: up down test

up:
    docker-compose up -d

down:
    docker-compose down

test:
    curl -f http://localhost:8080/health || (echo "Health check failed" && exit 1)
