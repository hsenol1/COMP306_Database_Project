# 0: Entering the virtual environment 
#### Make sure to be in virtual environment before installing new packages or running the app
source env/bin/activate
#### Make sure that you install the necessary libraries 
pip install requirements.txt

# Running the app:
// Make sure you are in the upper SupermarketAPI folder
python manage.py runserver

# 1: Creating the Database and Tables
// Make sure you are in the Backend folder
mysql -u root -p
(Password should be 123456)
source CreateDbAndTables.sql;

# 2: Import from the supermarket-export.sql file
// Make sure you are in the Backend folder
mysql -u root -p supermarketdb < supermarket-export.sql

# 3: Inserting data from xlsx files
// Make sure you are in the upper SupermarketAPI folder, csv files should be placed in the csv_files folder
python manage.py csv_to_db <table_name> <path_to_csv_file> --truncate [optional]

# 4: Export sql to the supermarket-export.sql file
// Make sure you are in the Backend folder
mysqldump -u root -p supermarketdb > supermarket-export.sql

# Register user using request
Send a POST request to http://127.0.0.1:8000/register-customer/ with Body like:

{
    "home_address": "ayilmaz_sample_Address",
    "city": "istanbul",
    "phone": "05321234567",
    "u_name": "Ahmet",
    "surname": "Yılmaz",
    "username": "ayılmaz",
    "pwd": "pwd4"
}
