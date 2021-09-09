# DBT with Postgres

Copy Postgres JDBC driver to the `jars` directory in `$SPARK_HOME`

    docker cp drivers/postgresql-42.2.23.jar dbt-with-postgres_pyspark-notebook_1:/usr/local/spark/jars/
