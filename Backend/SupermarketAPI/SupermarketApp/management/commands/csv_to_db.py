from django.core.management.base import BaseCommand
import csv
from SupermarketApp.dao import executeRaw


class Command(BaseCommand):
    help = 'Import data from csv file'

    def add_arguments(self, parser):
        parser.add_argument('table_name', type=str, help="Table name")
        parser.add_argument('path', type=str, help="Path to csv file")
        parser.add_argument("--truncate", action="store_true", help="Truncate table before import")

    def handle(self, *args, **options):
        table_name = options['table_name']
        path = "csv_files/" + options['path']
        if options['truncate']:
            executeRaw(f"DELETE FROM {table_name}")

        with open(path, 'r') as csv_data:
            reader = csv.reader(csv_data)
            csv_data_list = list(reader)
            for row in csv_data_list:
                row = tuple(row)
                executeRaw(f"INSERT INTO {table_name} VALUES {row}")
                