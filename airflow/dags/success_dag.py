from airflow import DAG
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from datetime import datetime


def print_hello():
    return "Hello world!"


default_args = {
    "owner": "airflow",
    "start_date": datetime(2023, 1, 1),
    "retries": 1,
}

with DAG("successful_dag", default_args=default_args, schedule_interval="@once") as dag:
    start = EmptyOperator(task_id="start")
    hello_task = PythonOperator(task_id="hello_task", python_callable=print_hello)
    end = EmptyOperator(task_id="end")

    start >> hello_task >> end
