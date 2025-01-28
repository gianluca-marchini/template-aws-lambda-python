# Docker
docker-stop:
	docker compose down --volumes --remove-orphans
docker-run:
	docker compose up -d --build
docker-reset: docker-stop docker-run

# Application
check-app:
	ruff format ./src && \
	ruff format ./tests && \
	ruff check --fix ./src && \
	ruff check --fix ./tests
test-app:
	pytest

# Deployment
clear-dependencies:
	rm -rf dependencies/
build-dependencies:
	pip install -t dependencies -r requirements.txt
clear-build-app:
	rm aws_lambda_artifact.zip
build-app:
	(cd dependencies;  zip ../aws_lambda_artifact.zip -r .) && (cd src; zip ../aws_lambda_artifact.zip -u lambda_function.py)