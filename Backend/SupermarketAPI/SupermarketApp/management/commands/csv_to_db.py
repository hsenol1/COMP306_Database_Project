from django.core.management.base import BaseCommand
import csv
from SupermarketApp.dao import executeRaw, get_next_id


class Command(BaseCommand):
    help = 'Import data from csv file'

    def add_arguments(self, parser):
        parser.add_argument('table_name', type=str, help="Table name")
        parser.add_argument('path', type=str, help="Path to csv file")
        parser.add_argument("--truncate", action="store_true", help="Truncate table before import")
        parser.add_argument("auto_id_column", nargs=1, default=None, help="Auto id column name of table (if any)")

    def handle(self, *args, **options):
        table_name = options['table_name']
        path = "csv_files/" + options['path']
        if options['truncate']:
            executeRaw(f"DELETE FROM {table_name}")

        with open(path, 'r') as csv_data:
            reader = csv.reader(csv_data)
            csv_data_list = list(reader)
            for row in csv_data_list:
                if options['auto_id_column']:
                    row.insert(0, get_next_id(table_name, options['auto_id_column'][0]))
                row = tuple(row)
                executeRaw(f"INSERT INTO {table_name} VALUES {row}")
                