from pyspark.sql import SparkSession

spark = SparkSession.builder \
        .master('local') \
        .getOrCreate()
sc = spark.sparkContext

rdd = sc.parallelize(range(100 + 1))
print(rdd.sum())