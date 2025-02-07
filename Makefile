DB_HOST := localhost
DB_PORT := 5432
DB_USER := postgres
DB_NAME := postgres
DBT_PROFILES_DIR := ~/.dbt
SQL_FILES := $(wildcard src/sql/*.sql)

.PHONY: all
all: up down convert_csv execute_sql run_dbt

up:
	docker-compose --project-name dbt --file docker/docker-compose.yml up -d

down:
	docker-compose down

# Convert XLSX to CSV
.PHONY: convert_csv
convert_csv:
	@echo "Converting XLSX to CSV..."
	python3 src/scripts/xlsx_to_csv.py

# Create tables and load data
.PHONY: execute_sql
execute_sql:
	@echo "Executing SQLs....";\
	for file in $(SQL_FILES); do \
		echo "Executing $$file..."; \
		psql -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) -d $(DB_NAME) -f $$file; \
	done

# Run dbt models
.PHONY: run_dbt
run_dbt:
	@echo "Running dbt models..."
	dbt build --profiles-dir $(DBT_PROFILES_DIR)

