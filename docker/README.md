This folder contains the resources required by the dockerized services defined in the `docker-compose.yml` file.

For example, a dockerized `mysql` service could need a `./docker/mysql/sql/` folder containing all the `.sql` scripts to run during its initialization:
- `01_create_database.sql`
- `02_create_tables.sql`
- `03_insert_data.sql`
- etc...
