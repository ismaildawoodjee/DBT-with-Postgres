# DBT with Postgres

Using Python `v3.8.10` on Ubuntu Linux `v20.04`, with Docker `v20.10.8`,
docker-compose `v1.29.2` and DBT `v0.20.2`.

## Setup

1. Pre-setup for Ubuntu/Debian distros

        sudo apt-get install git libpq-dev python-dev python3-pip
        sudo apt-get remove python-cffi
        sudo pip install -U cffi
        pip install cryptography~=3.4

2. Create a Python virtual environment and activate it

        python3 -m venv .venv; source .venv/bin/activate

3. Install libraries (upgrading `pip` if necessary)

        pip install -U wheel setuptools; pip install -U dbt

4. Initialize DBT project and go inside it

        dbt init DBT-with-Postgres; cd DBT-with-Postgres

5. Initialize Git

        git init

6. Build Docker containers specified in the `docker-compose.yml` file

        docker-compose up --build -d

7. Create a  `profiles.yml` file in the `~/.dbt/` directory and add the
   following.

    ```yaml
    darmadia:  # the profile_name, typically a company name, with one profile for each warehouse
    target: dev-postgres-dest
    outputs:
        dev-postgres-dest:
        type: postgres  # type of connection
        host: localhost  
        user: destdb1
        password: destdb1
        port: 5434
        dbname: destdb
        schema: public
        threads: 4
        keepalives_idle: 0
        # search_path: [optional, override the default postgres search_path]
        # role: [optional, set the role dbt assumes when executing queries]
        # sslmode: [optional, set the sslmode used to connect to the database]
    ```

    Run the debug command to test connection to database

        dbt debug

8. Run the example models to confirm that setup is successful

        dbt run

## Spark Container

Copy Postgres JDBC driver to the `jars` directory in `SPARK_HOME=/usr/local/spark`

    docker cp drivers/postgresql-42.2.23.jar dbt-with-postgres_pyspark-notebook_1:/usr/local/spark/jars/
