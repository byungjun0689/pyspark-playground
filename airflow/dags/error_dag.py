from airflow import DAG
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from datetime import datetime


def raise_error():
    raise ValueError(
        "This is an intentional error.\n"
        "Line 1: Something went wrong.\n"
        "Line 2: Please check the configuration.\n"
        "Line 3: Ensure all dependencies are installed.\n"
        "Line 4: Refer to the documentation for more details.\n"
        "Line 5: Contact support if the issue persists."
    )


default_args = {
    "owner": "airflow",
    "start_date": datetime(2023, 1, 1),
    "retries": 1,
}

with DAG("error_dag", default_args=default_args, schedule_interval="@once") as dag:
    start = EmptyOperator(task_id="start")
    error_task = PythonOperator(task_id="error_task", python_callable=raise_error)
    end = EmptyOperator(task_id="end")

    start >> error_task >> end
