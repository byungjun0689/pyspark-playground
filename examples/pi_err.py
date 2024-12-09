from pyspark.sql import SparkSession
import logging
import sys
from random import random
from operator import add


class WarnFilter(logging.Filter):
    def filter(self, record):
        return record.levelno == logging.WARNING


class InfoFilter(logging.Filter):
    def filter(self, record):
        return record.levelno == logging.INFO


class ErrorFilter(logging.Filter):
    def filter(self, record):
        return record.levelno == logging.ERROR


# 로거 생성
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# 핸들러 생성
info_handler = logging.StreamHandler()
error_handler = logging.StreamHandler()
warn_handler = logging.StreamHandler()

# 필터 추가
info_handler.addFilter(InfoFilter())
error_handler.addFilter(ErrorFilter())
warn_handler.addFilter(WarnFilter())

date_format = "%y/%m/%d %H:%M:%S"
# 포맷 설정
info_format = logging.Formatter("%(asctime)s INFO %(message)s", datefmt=date_format)
error_format = logging.Formatter("%(asctime)s ERROR %(message)s", datefmt=date_format)
warn_format = logging.Formatter("%(asctime)s WARN %(message)s", datefmt=date_format)

log_format = "%(asctime)s %(levelname)s %(message)s"

info_handler.setFormatter(info_format)
error_handler.setFormatter(error_format)
warn_handler.setFormatter(warn_format)

# 핸들러 추가
logger.addHandler(info_handler)
logger.addHandler(error_handler)
logger.addHandler(warn_handler)

if __name__ == "__main__":
    """
    Usage: pi [partitions]
    """
    spark = SparkSession.builder.appName("PythonPi").getOrCreate()

    partitions = int(sys.argv[1]) if len(sys.argv) > 1 else 2
    n = 100000 * partitions

    def f(_: int) -> float:
        x = random() * 2 - 1
        y = random() * 2 - 1
        return 1 if x**2 + y**2 <= 1 else 0

    count = (
        spark.sparkContext.parallelize(range(1, n + 1), partitions).map(f).reduce(add)
    )
    print("Pi is roughly %f" % (4.0 * count / n))

    # Introduce an error by trying to read from a non-existent HDFS path
    df = spark.read.csv("hdfs:///non_existent_path/file.csv")
    df.show()

    spark.stop()
