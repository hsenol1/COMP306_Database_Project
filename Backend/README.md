# 0: Entering the virtual environment 
#### Make sure to be in virtual environment before installing new packages or running the app
source env/bin/activate

# 1: Creating the Database and Tables
// Make sure you are in the Backend folder
mysql -u root -p
(Password should be 123456)
source CreateDbAndTables.sql;

# 2: Import from the supermarket-export.sql file
// Make sure you are in the Backend folder
mysql -u root -p supermarketdb < supermarket-export.sql

# 3: Inserting data from xlsx files
// Make sure you are in the upper SupermarketAPI folder
python manage.py csv_to_db <table_name> <path_to_csv_file> --truncate [optional]

# 4: Export sql to the supermarket-export.sql file
// Make sure you are in the Backend folder
mysqldump -u root -p supermarketdb > supermarket-export.sql