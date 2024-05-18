from django.db import connection
from django.db import transaction

@transaction.atomic
def executeRaw(query):
    with connection.cursor() as cursor:
        cursor.execute(query)
        return cursor.fetchall()

@transaction.atomic
def get_next_id(table_name, id_column_name):
    with connection.cursor() as cursor:
        cursor.execute(f"SELECT MAX({id_column_name}) FROM {table_name}")
        result = cursor.fetchone()
        if (result is None) or (result[0] is None):
            return 1
        return result[0] + 1

@transaction.atomic
def insert_one(table_name, *values):
    values = map(lambda x: "'" + str(x) + "'", values)
    values = ", ".join(values)
    with connection.cursor() as cursor:
        cursor.execute(f"INSERT INTO {table_name} VALUES ({values})")