from django.db import connection

def executeRaw(query):
    with connection.cursor() as cursor:
        cursor.execute(query)
        return cursor.fetchall()