from django.shortcuts import render
from rest_framework.parsers import JSONParser
from django.views.decorators.csrf import csrf_exempt
from SupermarketApp.dao import executeRaw, get_next_id, insert_one
from django.http import HttpResponse
from django.db import transaction
import json
from decimal import Decimal
from datetime import datetime
import decimal
from django.core.serializers.json import DjangoJSONEncoder  
import random

# Create your views here.

@csrf_exempt
def register_customer(request):
    if request.method != 'POST':
        response = HttpResponse("register_customer only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    u_id = get_next_id("Users", "u_id")
    home_address = value["home_address"]
    city = value["city"]
    phone = value["phone"]
    u_name = value["u_name"]
    surname = value["surname"]
    username = value["username"]
    pwd = value["pwd"]
    if not (home_address and city and phone and u_name and surname and username and pwd):
        response = HttpResponse("empty field in register_customer body")
        response.status_code = 400
        return response
    
    existing_user_result = executeRaw(f"select * from Users where username = '{username}'")

    if len(existing_user_result) > 0:
        response = HttpResponse("Username already exists")
        response.status_code = 409
        return response
    with transaction.atomic():
        insert_one("Users", u_id, u_name, surname, username, pwd)
        insert_one("Customers", home_address, city, phone, u_id)
    response = HttpResponse("Customer created successfully")
    response.status_code = 201
    return response

@csrf_exempt
def login_user(request):
    if request.method != 'POST':
        response = HttpResponse("login_user only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "username" not in value:
        response = HttpResponse("username not found in request body")
        response.status_code = 400
        return response
    if "pwd" not in value:
        response = HttpResponse("pwd not found in request body")
        response.status_code = 400
        return response
    username = value["username"]
    pwd = value["pwd"]
    result = executeRaw(f"select * from Users where username = '{username}' and pwd = '{pwd}'")
    if len(result) == 0:
        response = HttpResponse("Invalid username or password")
        response.status_code = 401
        return response
    result = convert_decimals_and_datetimes_to_str(result)
    result = result[0]
    user_id = result[0]

    admin_result = executeRaw(f"select * from Admins where u_id = {user_id}")
    if len(admin_result) > 0:
        admin_result = convert_decimals_and_datetimes_to_str(admin_result)
        admin_result = admin_result[0]
        admin_result = {'admin_info': admin_result}
        result.append(admin_result)
    else:
        customer_result = executeRaw(f"select * from Customers where u_id = {user_id}")
        if len(customer_result) > 0:
            customer_result = convert_decimals_and_datetimes_to_str(customer_result)
            customer_result = customer_result[0]
            customer_result = {'customer_info': customer_result}
            result.append(customer_result)
        else:
            response = HttpResponse("User is neither admin nor customer")
            response.status_code = 401
            return response

    
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response

@csrf_exempt
def get_categories(request):
    if request.method != 'GET':
        response = HttpResponse("get_categories only accepts GET requests")
        response.status_code = 405
        return response
    result = executeRaw("select distinct category from Products")
    if len(result) == 0:
        response = HttpResponse("No categories found")
        response.status_code = 420
        return response
    result = map(lambda x: x[0], result)
    result = json.dumps(list(result))
    response = HttpResponse(result)
    response.status_code = 200
    return response

@csrf_exempt
def get_products_by_category(request):
    if request.method != 'POST':
        response = HttpResponse("get_products_by_category only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "category" not in value:
        response = HttpResponse("category not found in request body")
        response.status_code = 400
        return response
    category = value["category"]
    result = executeRaw(f"select * from Products where category = '{category}'")
    if len(result) == 0:
        response = HttpResponse("No products found")
        response.status_code = 420
        return response
    
    result = convert_decimals_and_datetimes_to_str(result)
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response

@csrf_exempt
def get_products_by_search(request):
    if request.method != 'POST':
        response = HttpResponse("get_products_by_search only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "search" not in value:
        response = HttpResponse("search not found in request body")
        response.status_code = 400
        return response
    search = value["search"]
    result = executeRaw(f"select * from Products where p_name like '%{search}%'")
    if len(result) == 0:
        response = HttpResponse("No products found")
        response.status_code = 420
        return response
    result = convert_decimals_and_datetimes_to_str(result)
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response

@csrf_exempt
def is_user_admin_by_username(request):
    if request.method != 'POST':
        response = HttpResponse("is_user_admin_by_username only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "username" not in value:
        response = HttpResponse("username not found in request body")
        response.status_code = 400
        return response
    username = value["username"]
    result = executeRaw(f"select * from Users where username = '{username}'")
    if len(result) == 0:
        response = HttpResponse("No user found")
        response.status_code = 420
        return response
    result = convert_decimals_and_datetimes_to_str(result)
    result = result[0]
    user_id = result[0]
    admin_result = executeRaw(f"select * from Admins where u_id = {user_id}")
    if len(admin_result) == 0:
        response = HttpResponse("False")
        response.status_code = 200
        return response
    response = HttpResponse("True")
    response.status_code = 200
    return response

@csrf_exempt
def get_admin_data_by_username(request):
    if request.method != 'POST':
        response = HttpResponse("get_user_data_by_username only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "username" not in value:
        response = HttpResponse("username not found in request body")
        response.status_code = 400
        return response
    username = value["username"]
    result = executeRaw(f"select * from Users where username = '{username}'")
    if len(result) == 0:
        response = HttpResponse("No user found")
        response.status_code = 420
        return response
    result = convert_decimals_and_datetimes_to_str(result)
    result = result[0]
    user_id = result[0]
    admin_result = executeRaw(f"select * from Admins where u_id = {user_id}")
    if len(admin_result) == 0:
        response = HttpResponse("User is not an admin")
        response.status_code = 420
        return response
    result.append(admin_result[0])
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response

@csrf_exempt
def get_customer_data_by_username(request):
    if request.method != 'POST':
        response = HttpResponse("get_user_data_by_username only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "username" not in value:
        response = HttpResponse("username not found in request body")
        response.status_code = 400
        return response
    username = value["username"]
    result = executeRaw(f"select * from Users where username = '{username}'")
    if len(result) == 0:
        response = HttpResponse("No user found")
        response.status_code = 420
        return response
    result = convert_decimals_and_datetimes_to_str(result)
    result = result[0]
    user_id = result[0]
    customer_result = executeRaw(f"select * from Customers where u_id = {user_id}")
    if len(customer_result) == 0:
        response = HttpResponse("User is not a customer")
        response.status_code = 420
        return response
    result.append(customer_result[0])
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response



def get_template(func_name, query):
    result = executeRaw(query)
    if len(result) == 0:
        response = HttpResponse(func_name + " returned none")
        response.status_code = 420
        return response
    result = convert_decimals_and_datetimes_to_str(result)
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response



@csrf_exempt
def delete_template(request, table_name, id_field):
    if request.method != 'POST':
        response = HttpResponse(f"delete_{table_name} only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "id" not in value:
        response = HttpResponse(f"{table_name} id not found in request body")
        response.status_code = 400
        return response
    object_id = value["id"]
    existing_object_result = executeRaw(f"SELECT * FROM {table_name} WHERE {id_field} = '{object_id}'")
    if len(existing_object_result) == 0:
        response = HttpResponse(f"{table_name} not found")
        response.status_code = 420
        return response
    with transaction.atomic():
        executeRaw(f"DELETE FROM {table_name} WHERE {id_field} = '{object_id}'")
    response = HttpResponse(f"{table_name} deleted successfully")
    response.status_code = 200
    return response
  


@csrf_exempt
def get_products(request):
    response = get_template('get_products', "select * from Products")
    return response


# COMPLEX QUERY
#WARNING: get_low_stock_products returns lowest stock product from each category
@csrf_exempt
def get_low_stock_products(request):
    response = get_template('get_low_stock_products', """SELECT * 
                                                                    FROM Products p1 
                                                                    WHERE stock_amount = (
                                                                        SELECT MIN(stock_amount) 
                                                                        FROM Products p2 
                                                                        WHERE p2.category = p1.category
                                                                        );""")
    return response


# COMPLEX QUERY
@csrf_exempt
def get_products_with_higher_than_4_rating(request):
    response = get_template('get_products_with_higher_than_4_rating', """SELECT p.p_id, p.stock_amount, p.category, p.price, p.p_name 
                                                                                    FROM Products p
                                                                                    JOIN Order_Products op ON p.p_id = op.p_id
                                                                                    JOIN Order_Placements opl ON op.o_id = opl.o_id
                                                                                    GROUP BY p.p_id
                                                                                    HAVING AVG(opl.rating) > 4""")
    return response


# COMPLEX QUERY
@csrf_exempt
def get_top_5_lowest_rated_products(request):
    response = get_template('get_top_5_lowest_rated_products', """SELECT p.p_id, p.stock_amount, p.category, p.price, p.p_name
                                                                            FROM Products p
                                                                            JOIN Order_Products op ON p.p_id = op.p_id
                                                                            JOIN Order_Placements opl ON op.o_id = opl.o_id
                                                                            GROUP BY p.p_id
                                                                            ORDER BY AVG(rating) ASC
                                                                            LIMIT 5;""")
    return response



@csrf_exempt
def increase_product_quantity(request):
    if request.method != 'POST':
        response = HttpResponse("increase_product_quantity only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "p_id" not in value or "quantity" not in value:
        response = HttpResponse("p_id or quantity not found in request body")
        response.status_code = 400
        return response
    p_id = value["p_id"]
    quantity = value["quantity"]
    # Ensure quantity is a positive integer
    if not isinstance(quantity, int) or quantity <= 0:
        response = HttpResponse("quantity must be a positive integer")
        response.status_code = 400
        return response
    # Update the product quantity in the database
    with transaction.atomic():
        executeRaw(f"UPDATE Products SET stock_amount = stock_amount + {quantity} WHERE p_id = {p_id}")
    response = HttpResponse("Product quantity increased successfully")
    response.status_code = 200
    return response



@csrf_exempt
def decrease_product_quantity(request):
    if request.method != 'POST':
        response = HttpResponse("decrease_product_quantity only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "p_id" not in value or "quantity" not in value:
        response = HttpResponse("p_id or quantity not found in request body")
        response.status_code = 400
        return response
    p_id = value["p_id"]
    quantity = value["quantity"]
    # Ensure quantity is a positive integer
    if not isinstance(quantity, int) or quantity <= 0:
        response = HttpResponse("quantity must be a positive integer")
        response.status_code = 400
        return response
    # Update the product quantity in the database
    with transaction.atomic():
        # Ensure there are enough products in stock
        result = executeRaw(f"SELECT stock_amount FROM Products WHERE p_id = {p_id}")
        if len(result) == 0 or result[0][0] < quantity:
            response = HttpResponse("Not enough products in stock. Won't update quantity.")
            response.status_code = 400
            return response
        executeRaw(f"UPDATE Products SET stock_amount = stock_amount - {quantity} WHERE p_id = {p_id}")
    response = HttpResponse("Product quantity decreased successfully")
    response.status_code = 200
    return response



@csrf_exempt
def get_customers(request):
    response = get_template('get_customers', "select * from Customers JOIN Users ON Customers.u_id = Users.u_id")
    return response


@csrf_exempt
def get_one_customer_per_city(request):
    response = get_template('get_one_customer_per_city', """SELECT c.*, u.*
                                                                        FROM Customers c
                                                                        JOIN Users u ON c.u_id = u.u_id
                                                                        JOIN (
                                                                            SELECT city, MIN(u_id) as min_u_id
                                                                            FROM Customers
                                                                            GROUP BY city
                                                                        ) as subquery
                                                                        ON c.u_id = subquery.min_u_id;
                                                                        """)
    return response

#COMPLEX QUERY
@csrf_exempt
@transaction.atomic
def give_voucher_to_one_customer_per_city(request, voucher_id):
    if voucher_id == 0:
        response = HttpResponse("Voucher id cannot be 0")
        response.status_code = 400
        return response
    customers = executeRaw("""SELECT c.*, u.*
                            FROM Customers c
                            JOIN Users u ON c.u_id = u.u_id
                            JOIN (
                                SELECT city, MIN(u_id) as min_u_id
                                FROM Customers
                                GROUP BY city
                            ) as subquery
                            ON c.u_id = subquery.min_u_id;
                            """)
    customers = convert_decimals_and_datetimes_to_str(customers)
    u_ids = [customer[3] for customer in customers]
    for u_id in u_ids:
        current_voucher_result = executeRaw(f"SELECT v_amount FROM Customer_Vouchers WHERE u_id = {u_id} AND v_id = {voucher_id}")
        if not current_voucher_result or len(current_voucher_result) <= 0:
            insert_one("Customer_Vouchers", u_id, voucher_id, 1)
        else:
            current_voucher_amount = current_voucher_result[0][0]
            executeRaw(f"UPDATE Customer_Vouchers SET v_amount = {current_voucher_amount + 1} WHERE u_id = {u_id} AND v_id = {voucher_id}")
    customers = json.dumps(customers)
    response = HttpResponse(customers)
    response.status_code = 200
    return response

@csrf_exempt
def get_products_from_order(request, order_id):
    if request.method != 'GET':
        response = HttpResponse("get_products_from_order only accepts GET requests")
        response.status_code = 405
        return response
    query = f"""
            SELECT p.p_id, p.stock_amount, p.category, op.purchased_price, p.p_name, op.p_amount, op.purchased_price
            FROM Products p
            INNER JOIN Order_Products op ON p.p_id = op.p_id
            WHERE op.o_id = {order_id};
            """
    return get_template("get_products_from_order", query)

@csrf_exempt
def rate_order_by_o_id(request):
    if request.method != 'POST':
        response = HttpResponse("rate_order_by_o_id only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "o_id" not in value:
        response = HttpResponse("o_id not found in request body")
        response.status_code = 400
        return response
    o_id = value["o_id"]
    rating = value["rating"]
    if not (1 <= rating <= 5):
        response = HttpResponse("Invalid rating. It must be between 1 and 5.")
        response.status_code = 400
        return response
    rating_result = executeRaw(f"SELECT rating FROM Order_Placements op WHERE op.o_id = {o_id}")
    if len(rating_result) == 0:
        response = HttpResponse("Order not found in Order_Placements table")
        response.status_code = 420
        return response
    old_rating = rating_result[0][0]
    if old_rating is not None and old_rating != 0:
        response = HttpResponse("Order already rated")
        response.status_code = 400
        return response
    with transaction.atomic():
        executeRaw(f"UPDATE Order_Placements SET rating = {rating} WHERE o_id = {o_id}")
    response = HttpResponse("Order rated successfully")
    response.status_code = 200
    return response

@csrf_exempt
def get_order_history_by_u_id(request):
    # rating, order.*, v_name, [opr.*, p_name]
    if request.method != 'POST':
        response = HttpResponse("get_order_history_by_u_id only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "u_id" not in value:
        response = HttpResponse("u_id not found in request body")
        response.status_code = 400
        return response
    u_id = value["u_id"]
    result = executeRaw(f"SELECT o.*, v.v_name, opl.rating FROM Order_Placements opl JOIN Orders o ON opl.o_id = o.o_id JOIN Vouchers v ON opl.v_id = v.v_id WHERE opl.u_id = {u_id} AND o.order_status != 'IN_PROGRESS'")
    result = convert_decimals_and_datetimes_to_str(result)
    
    for order in result:
        o_id = order[0]
        order_products = executeRaw(f"SELECT p.p_name, opr.* FROM Order_Products opr JOIN Products p ON opr.p_id = p.p_id WHERE opr.o_id = {o_id}")
        order_products = convert_decimals_and_datetimes_to_str(order_products)
        order.append(order_products)

    result = convert_decimals_and_datetimes_to_str(result)
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response

@csrf_exempt
def get_vouchers(request):
    response = get_template('get_vouchers', "select * from vouchers where v_id != 0")
    return response

@csrf_exempt
def give_voucher_by_u_id_and_v_id(request):
    if request.method != 'POST':
        response = HttpResponse("give_voucher_by_u_id only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "u_id" not in value:
        response = HttpResponse("u_id not found in request body")
        response.status_code = 400
        return response
    u_id = value["u_id"]
    if "v_id" not in value:
        response = HttpResponse("v_id not found in request body")
        response.status_code = 400
        return response
    v_id = value["v_id"]

    if v_id == 0:
        response = HttpResponse("Voucher id cannot be 0")
        response.status_code = 400
        return response
    
    result = executeRaw (f"SELECT v_amount FROM Customer_Vouchers WHERE u_id = {u_id} AND v_id = {v_id}")
    if len(result) == 0 or result[0][0] == 0:
        executeRaw(f"INSERT INTO Customer_Vouchers VALUES ({u_id}, {v_id}, 1)")
        response = HttpResponse("Voucher given successfully")
        response.status_code = 200
        return response
    
    executeRaw(f"UPDATE Customer_Vouchers SET v_amount = v_amount + 1 WHERE u_id = {u_id} AND v_id = {v_id}")
    response = HttpResponse("Voucher given successfully")
    response.status_code = 200
    return response

@csrf_exempt
def insert_voucher(request):
    if request.method != 'POST':
        response = HttpResponse("insert_voucher only accepts POST requests")
        response.status_code = 405
        return response
    try:
        value = JSONParser().parse(request)
        v_id = get_next_id("Vouchers", "v_id")
        discount_rate = value["discount_rate"]
        v_name = value["v_name"]
        if not (1 <= discount_rate <= 100):
            response = HttpResponse("Invalid discount_rate. It must be between 1 and 100.")
            response.status_code = 400
            return response
        with transaction.atomic():
            insert_one("Vouchers", v_id, discount_rate, v_name)
        response = HttpResponse("Voucher created successfully")
        response.status_code = 201
    except Exception as e:
        response = HttpResponse(str(e))
        response.status_code = 400
    return response




@csrf_exempt
def delete_product(request):
    return delete_template(request, "Products", "p_id")

@csrf_exempt
def delete_customer(request, table_name = 'Customers', id_field ='u_id'):
    if request.method != 'POST':
        response = HttpResponse(f"delete_{table_name} only accepts POST requests")
        response.status_code = 405
        return response
    value = JSONParser().parse(request)
    if "id" not in value:
        response = HttpResponse(f"{table_name} id not found in request body")
        response.status_code = 400
        return response
    object_id = value["id"]
    existing_object_result = executeRaw(f"SELECT * FROM {table_name} WHERE {id_field} = '{object_id}'")
    if len(existing_object_result) == 0:
        response = HttpResponse(f"{table_name} not found")
        response.status_code = 420
        return response
    with transaction.atomic():
        executeRaw(f"DELETE FROM {table_name} WHERE {id_field} = '{object_id}'")
        executeRaw(f"DELETE FROM Users WHERE {id_field} = '{object_id}'")
    response = HttpResponse(f"{table_name} deleted successfully")
    response.status_code = 200
    return response

@csrf_exempt
def delete_voucher(request):
    return delete_template(request, "Vouchers", "v_id")

@csrf_exempt
def get_last_10_orders(request):
    if request.method != 'POST':
        response = HttpResponse("get_last_10_order only accepts POST request.")
        response.status_code = 405
        return response

    try: 
        value = JSONParser().parse(request)
    except Exception as e:
        response = HttpResponse("Invalid JSON format.")
        response.status_code = 400
        return response
    
    if 'u_id' not in value:
        response = HttpResponse("u_id is not found in request body")
        response.status_code = 400
        return response
    
    u_id = value["u_id"]
    customer_exists = executeRaw(f"SELECT * FROM Customers WHERE u_id = {u_id}")
    if len(customer_exists) == 0:
        response = HttpResponse("u_id does not exist in Customers table")
        response.status_code = 400
        return response

    try:
        existing_orders = executeRaw(f"SELECT * FROM Orders o JOIN Order_Placements op ON o.o_id = op.o_id WHERE op.u_id = {u_id}")
        print(existing_orders)
        result = json.dumps(existing_orders, cls=DjangoJSONEncoder)
        response = HttpResponse(result)
        response.status_code = 200
    except Exception as e:
        response = HttpResponse(f"Internal Server Error: {str(e)}")
        response.status_code = 500
    return response

def decimal_default(obj):
    if isinstance(obj, decimal.Decimal):
        return float(obj)
    raise TypeError



@csrf_exempt
@transaction.atomic
def assign_random_vouchers(request, voucher_id):
    if voucher_id == 0:
        response = HttpResponse("Voucher id cannot be 0")
        response.status_code = 400
        return response
    cities = executeRaw("SELECT DISTINCT city FROM Customers")
    cities = [city[0] for city in cities]
    selected_cities = random.sample(cities, min(len(cities), 5))  # Ensure not to exceed the number of available cities
    response_message = []
    for city in selected_cities:
        customer_result = executeRaw(f"SELECT u_id FROM Customers WHERE city = '{city}'")
        customers = [customer[0] for customer in customer_result]
        sample_size = min(len(customers), 5)  # Ensure not to exceed the number of available customers
        selected_customers = random.sample(customers, sample_size)
        for u_id in selected_customers:
            current_voucher_result = executeRaw(f"SELECT v_amount FROM Customer_Vouchers WHERE u_id = {u_id} AND v_id = {voucher_id}")
            if not current_voucher_result or len(current_voucher_result) <= 0:
                insert_one("Customer_Vouchers", u_id, voucher_id, 1)
            else:
                current_voucher_amount = current_voucher_result[0][0]
                executeRaw(f"UPDATE Customer_Vouchers SET v_amount = {current_voucher_amount + 1} WHERE u_id = {u_id} AND v_id = {voucher_id}")
            response_message.append(f"Voucher assigned to user {u_id} in city {city}")
    response = HttpResponse("\n".join(response_message))
    response.status_code = 200
    return response




def is_enough_stock(p_id, p_amount):
    result = executeRaw(f"SELECT stock_amount FROM Products WHERE p_id = {p_id}")
    if not result: 
        return False, f"Product with p_id:{p_id} does not exists"
    stock_amount = result[0][0]
    if p_amount > stock_amount:
        return False, f"Available stock: {stock_amount}, Requested: {p_amount}. Request is not completed."
    
    return True, None 

@csrf_exempt
def get_vouchers_by_u_id(request):
    if request.method != 'POST':
        response = HttpResponse("get_vouchers_by_u_id only accepts POST requests")
        response.status_code = 405
        return response 
    

    try: 
        value = JSONParser().parse(request)
    except Exception as e:
        response = HttpResponse("Invalid JSON format.")
        response.status_code = 400
        return response
    
    if 'u_id' not in value:
        response = HttpResponse("u_id is not found in request body")
        response.status_code = 400
        return response
    
    u_id = value['u_id']

    try:
        result = executeRaw(f"SELECT cv.v_amount, v.* FROM Customer_Vouchers cv JOIN Vouchers v ON cv.v_id = v.v_id WHERE cv.u_id = {u_id}")
        result = convert_decimals_and_datetimes_to_str(result)
        result = json.dumps(result, cls=DjangoJSONEncoder)
        response = HttpResponse(result)
        response.status_code = 200
    except Exception as e:
        response = HttpResponse(f"Internal Server Error: {str(e)}")
        response.status_code = 500
    return response

@csrf_exempt
def delete_basket(request):
    if request.method != 'POST':
        response = HttpResponse("delete_basket only accepts POST requests")
        response.status_code = 405
        return response 
    
    try: 
        value = JSONParser().parse(request)
    except Exception as e:
        response = HttpResponse("Invalid JSON format.")
        response.status_code = 400
        return response
    
    if 'u_id' not in value:
        response = HttpResponse("u_id is not found in request body")
        response.status_code = 400
        return response
    
    u_id = value['u_id']

    basket_id_result = executeRaw(f"SELECT o.o_id FROM Orders o JOIN Order_Placements op ON o.o_id = op.o_id WHERE op.u_id = {u_id} AND o.order_status = 'IN_PROGRESS'")
    if len(basket_id_result) == 0:
        response = HttpResponse("No basket found for this user")
        response.status_code = 404
        return response
    basket_id_result = convert_decimals_and_datetimes_to_str(basket_id_result)
    o_id = basket_id_result[0][0]

    result = executeRaw(f"SELECT order_status FROM Orders WHERE o_id = {o_id}")
    if not result or len(result) <= 0:
        response = HttpResponse("Basket does not exist")
        response.status_code = 400
        return response

    order_status = result[0][0]
    if order_status != "IN_PROGRESS":
        response = HttpResponse("Order is not basket")
        response.status_code = 400
        return response
    
    with transaction.atomic():
        executeRaw(f"DELETE FROM Order_Placements WHERE o_id = {o_id}")
        executeRaw(f"DELETE FROM Order_Products WHERE o_id = {o_id}")
        executeRaw(f"DELETE FROM Orders WHERE o_id = {o_id}")
        response = HttpResponse("Basket deleted successfully")
        response.status_code = 200
        return response


@csrf_exempt
def get_basket_by_u_id(request):
    if request.method != 'POST':
        response = HttpResponse("get_basket_by_u_id only accepts POST requests")
        response.status_code = 405
        return response 
    
    try: 
        value = JSONParser().parse(request)
    except Exception as e:
        response = HttpResponse("Invalid JSON format.")
        response.status_code = 400
        return response
    
    if 'u_id' not in value:
        response = HttpResponse("u_id is not found in request body")
        response.status_code = 400
        return response
    
    u_id = value['u_id']
    try:
        basket_id_result = executeRaw(f"SELECT o.o_id FROM Orders o JOIN Order_Placements op ON o.o_id = op.o_id WHERE op.u_id = {u_id} AND o.order_status = 'IN_PROGRESS'")
        if len(basket_id_result) == 0:
            response = HttpResponse("No basket found for this user 1")
            response.status_code = 420
            return response
        basket_id_result = convert_decimals_and_datetimes_to_str(basket_id_result)
        basket_id = basket_id_result[0][0]
        # id, name, price, amount
        result = executeRaw(f"SELECT p.p_id, p.p_name, p.price, op.p_amount FROM Products p JOIN Order_Products op ON p.p_id = op.p_id WHERE op.o_id = {basket_id}")
        result = convert_decimals_and_datetimes_to_str(result)
        if len(result) == 0:
            response = HttpResponse("No basket found for this user 2")
            response.status_code = 420
            return response

        response = HttpResponse(json.dumps(result, cls=DjangoJSONEncoder))
        response.status_code = 200
    except Exception as e:
        response = HttpResponse(f"Internal Server Error: {str(e)}")
        response.status_code = 500

    return response


@csrf_exempt
def complete_order(request):
    if request.method != 'POST':
        response = HttpResponse("complete_order only accepts POST requests")
        response.status_code = 405
        return response 
    
    try: 
        value = JSONParser().parse(request)
    except Exception as e:
        response = HttpResponse("Invalid JSON format.")
        response.status_code = 400
        return response
    
    if 'u_id' not in value:
        response = HttpResponse("u_id is not found in request body")
        response.status_code = 400
        return response
    
    u_id = value['u_id']
    existing_orders = executeRaw(f"SELECT * FROM Orders o JOIN Order_Placements op ON o.o_id = op.o_id WHERE op.u_id = {u_id} AND o.order_status = 'IN_PROGRESS'")
    if len(existing_orders) == 0:
        response = HttpResponse(f"There is not an existing IN-PROGRESS order for user: {u_id}")
        response.status_code = 409
        return response
    
    if len(existing_orders) > 1:
        response = HttpResponse(f"There exists more than one IN-PROGRESS order for user: {u_id}")
        response.status_code = 409
        return response 
    

    order = existing_orders[0]
    o_id = order[0]
    total_price = float(order[2])
    v_id = value.get('v_id', None)

    order_products = executeRaw(f"SELECT p_id, p_amount FROM Order_Products WHERE o_id = {o_id}")
    for product in order_products:
        p_id = product[0]
        p_amount = product[1]
        is_available, response_message = is_enough_stock(p_id, p_amount)
        if not is_available:
            response = HttpResponse(response_message)
            response.status_code = 408
            return response

    
    


    order_products = executeRaw(f"SELECT p_id, p_amount FROM Order_Products WHERE o_id = {o_id}")
    for product in order_products:
        p_id = product[0]
        p_amount = product[1]
        is_available, response_message = is_enough_stock(p_id, p_amount)
        if not is_available:
            response = HttpResponse(response_message)
            response.status_code = 400
            return response

    if v_id:
        total_price = apply_voucher(total_price, v_id, u_id)

    payment_type = value["payment_type"]
    with transaction.atomic():
        for product in order_products:
            p_id = product[0]
            p_amount = product[1]
            decrease_stock_amount(p_id, p_amount)
        
        if v_id:
            executeRaw(f"UPDATE Order_Placements SET v_id = {v_id} WHERE o_id = {o_id}")
        
        executeRaw(f"UPDATE Orders SET total_price = {total_price} WHERE o_id = {o_id}")
        executeRaw(f"UPDATE Orders SET order_status = 'delivered' WHERE o_id = {o_id}")
        executeRaw(f"UPDATE Orders SET payment_type = '{payment_type}' WHERE o_id = {o_id}")


    response = HttpResponse("Order completed succesfully, our staff started to prepare.")
    response.status_code = 200
    return response
    

def apply_voucher(total_price, v_id, u_id):
    voucher_result = executeRaw(f"SELECT v_amount FROM Customer_Vouchers WHERE u_id = {u_id} AND v_id = {v_id}")
    if len(voucher_result) == 0:
        raise ValueError(f"Voucher {v_id} is not found for User: {u_id}")

    v_amount = voucher_result[0][0]

    discount = executeRaw(f"SELECT discount_rate FROM Vouchers WHERE v_id = {v_id}")
    if len(discount) == 0:
        raise ValueError(f"Voucher ID {v_id} not found in Vouchers table")

    discount_rate = discount[0][0]

    total_price = total_price * (100 - discount_rate) / 100

    with transaction.atomic():
        if v_amount == 1:
            executeRaw(f"DELETE FROM Customer_Vouchers WHERE u_id = {u_id} AND v_id = {v_id}")
        else:
            executeRaw(f"UPDATE Customer_Vouchers SET v_amount = v_amount - 1 WHERE u_id = {u_id} AND v_id = {v_id}")


    return total_price

def decrease_stock_amount(p_id, p_amount):
    executeRaw(f"UPDATE Products SET stock_amount = stock_amount - {p_amount} WHERE p_id = {p_id}") 


@csrf_exempt
def add_item_to_bucket(request):
    if request.method != 'POST':
        response = HttpResponse("add_item_to_basket only accepts POST requests")
        response.status_code = 405
        return response 
    
    try: 
        value = JSONParser().parse(request)
    except Exception as e:
        response = HttpResponse("Invalid JSON format.")
        response.status_code = 400
        return response

    if 'u_id' not in value or 'p_id' not in value or 'p_amount' not in value:
        response = HttpResponse("u_id, p_id, or p_amount is not found in request body")
        response.status_code = 400
        return response        

    u_id = value["u_id"]
    p_id = value["p_id"]
    p_amount = value["p_amount"]

    customer_exists = executeRaw(f"SELECT * FROM Customers WHERE u_id = {u_id}")
    if len(customer_exists) == 0:
        response = HttpResponse("u_id does not exist in Customers table")
        response.status_code = 400
        return response
    
    
    purchased_price = get_product_price(p_id)
    if purchased_price is None:
        response = HttpResponse("p_id does not exist in Products table")
        response.status_code = 400
        return response
    
    is_available, response_message = is_enough_stock(p_id, p_amount)
    if not is_available:
        response = HttpResponse(response_message)
        response.status_code = 400
        return response

    existing_orders = executeRaw(f"SELECT * FROM Orders o JOIN Order_Placements op ON o.o_id = op.o_id WHERE op.u_id = {u_id} AND o.order_status = 'IN_PROGRESS'")
    if len(existing_orders) == 0:
        o_id = get_next_id("Orders", "o_id")
        order_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]
        order_status = "IN_PROGRESS"
        payment_type = "Not specified"
        total_price = purchased_price * p_amount

        with transaction.atomic():
            insert_one('Orders', o_id, payment_type, total_price, order_date, order_status)
            insert_one('Order_Placements', u_id, 0, o_id, 0) ## v_id and rating = -1, as placeholders.
            insert_one('Order_Products', p_id, o_id, p_amount,purchased_price)
            response = HttpResponse(f"Order {o_id} is created and product {p_id} is added successfully.")
            response.status_code=201
        return response
    
    if len(existing_orders) > 1: 
        response = HttpResponse("There exists more than one IN-PROGRESS order for user: {u_id}")
        response.status_code = 409
        return response
        
    order = existing_orders[0]
    o_id = order[0]
    total_price = order[2]

    existing_product = executeRaw(f"SELECT * FROM Order_Products WHERE o_id = {o_id} AND p_id = {p_id}")
    if len(existing_product) > 0:
        with transaction.atomic():
            new_amount = existing_product[0][2] + p_amount
            executeRaw(f"UPDATE Order_Products SET p_amount = {new_amount}, purchased_price = {purchased_price} WHERE o_id = {o_id} AND p_id = {p_id}")
            total_price += p_amount * purchased_price
            executeRaw(f"UPDATE Orders SET total_price = {total_price} WHERE o_id = {o_id}")
            response = HttpResponse("Item amount updated in basket successfully")
            response.status_code = 200
        return response
    

    with transaction.atomic():
        insert_one("Order_Products", p_id, o_id, p_amount, purchased_price)
        total_price += p_amount * purchased_price
        executeRaw(f"UPDATE Orders SET total_price = {total_price} WHERE o_id = {o_id}")
        response = HttpResponse("Item added to basket successfully")
        response.status_code = 201
    return response

def get_product_price(p_id):
    product = executeRaw(f"SELECT price FROM Products WHERE p_id = {p_id}")
    if len(product) == 0:
        return None
    return product[0][0]



@csrf_exempt
def create_order(request):
    if request.method != 'POST':
        response = HttpResponse("create_order only accepts POST request.")
        response.status_code = 405
        return response 
    

    try:
        value = JSONParser().parse(request)
    except Exception as e:
        response = HttpResponse("Invalid JSON format.")
        response.status_code = 400
        return response
    # value = JSONParser().parse(request)
    if 'u_id' not in value:
        response = HttpResponse("u_id is not found in request body")
        response.status_code = 400
        return response
    

    u_id = value["u_id"]

    customer_exists = executeRaw(f"SELECT * FROM Customers WHERE u_id = {u_id}")
    if len(customer_exists) == 0:
        response = HttpResponse("u_id does not exist in Customers table")
        response.status_code = 400
        return response

    existing_orders = executeRaw(f"SELECT * FROM Orders o JOIN Order_Placements op ON o.o_id = op.o_id WHERE op.u_id = {u_id} AND o.order_status = 'IN_PROGRESS'")
    if len(existing_orders) > 0:
        response = HttpResponse("There is already IN_ROGRESS Order exists for user_id: {u_id}.")
        response.status_code = 409
        return response
    

    o_id = get_next_id("Orders", "o_id")
    order_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]
    order_status = "IN_PROGRESS"
    payment_type = "Not specified"
    total_price = 0.0

    with transaction.atomic():
        # Create Order
        insert_one("Orders", o_id, payment_type, total_price, order_date,order_status)
        if "products" in value:
            for product in value["products"]:
                p_id = product["p_id"]
                p_amount = product["p_amount"]
                is_available, response_message = is_enough_stock(p_id, p_amount)
                if not is_available:
                    response = HttpResponse(response_message)
                    response.status_code = 400
                    return response
            
                purchased_price = product["price"]
                ## executeRaw(f"INSERT INTO Order_Products (p_id, o_id, p_amount, purchased_price) VALUES ({p_id}, {o_id}, {p_amount}, {purchased_price})")
                insert_one("Order_Products",p_id,o_id,p_amount, purchased_price)
                total_price += p_amount * purchased_price

        executeRaw(f"UPDATE Orders SET total_price = {total_price} WHERE o_id = {o_id}")
        
        # Create Order_Placement
        v_id = value["voucher_id"]
        rating = value["rating"]
        if v_id is None:
            v_id = get_next_id("Vouchers", "v_id")  # 

        executeRaw(f"INSERT INTO Order_Placements (u_id, v_id, o_id, rating) VALUES ({u_id}, {v_id}, {o_id}, {rating})")

           
    response = HttpResponse("Order created successfully")
    response.status_code = 201
    return response
        
## Example JSON
# # {
# #   "u_id": 10,
# #   "products": [
# #     {
# #       "p_id": 1,
# #       "p_amount": 2,
# #       "price": 3.50
# #     },
# #     {
# #       "p_id": 2,
# #       "p_amount": 1,
# #       "price": 1000.00
# #     }
# #   ],
# #   "voucher_id": 5,
# #   "rating": 4
# # }



def convert_decimals_and_datetimes_to_str(result):
    result = list(result)
    result = list(map(lambda x: list(x), result))
    for i in range(len(result)):
        for j in range(len(result[i])):
            if type(result[i][j]) == Decimal:
                result[i][j] = str(result[i][j])
            if type(result[i][j]) == datetime:
                result[i][j] = result[i][j].strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]
    
    return result

@csrf_exempt
def add_item_to_bucket(request):
    if request.method != 'POST':
        response = HttpResponse("add_item_to_basket only accepts POST requests")
        response.status_code = 405
        return response 
    
    try: 
        value = JSONParser().parse(request)
    except Exception as e:
        response = HttpResponse("Invalid JSON format.")
        response.status_code = 400
        return response

    if 'u_id' not in value or 'p_id' not in value or 'p_amount' not in value:
        response = HttpResponse("u_id, p_id, or p_amount is not found in request body")
        response.status_code = 400
        return response        

    u_id = value["u_id"]
    p_id = value["p_id"]
    p_amount = value["p_amount"]

    customer_exists = executeRaw(f"SELECT * FROM Customers WHERE u_id = {u_id}")
    if len(customer_exists) == 0:
        response = HttpResponse("u_id does not exist in Customers table")
        response.status_code = 400
        return response
    
    
    purchased_price = get_product_price(p_id)
    if purchased_price is None:
        response = HttpResponse("p_id does not exist in Products table")
        response.status_code = 400
        return response
    
    existing_orders = executeRaw(f"SELECT * FROM Orders o JOIN Order_Placements op ON o.o_id = op.o_id WHERE op.u_id = {u_id} AND o.order_status = 'IN_PROGRESS'")
    if len(existing_orders) == 0:
        o_id = get_next_id("Orders", "o_id")
        order_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]
        order_status = "IN_PROGRESS"
        payment_type = "Not specified"
        total_price = purchased_price * p_amount

        with transaction.atomic():
            insert_one('Orders', o_id, payment_type, total_price, order_date, order_status)
            insert_one('Order_Placements', u_id, 0, o_id, 0) ## v_id and rating = -1, as placeholders.
            insert_one('Order_Products', p_id, o_id, p_amount,purchased_price)
            response = HttpResponse(f"Order {o_id} is created and product {p_id} is added successfully.")
            response.status_code=201
        return response
    

    if len(existing_orders) > 1: ##if there exist more than one, raise error 
        response = HttpResponse("There exists more than one IN-PROGRESS order for user: {u_id}")
        response.status_code = 409
        return response

    order = existing_orders[0]
    o_id = order[0]
    total_price = order[2]

    existing_product = executeRaw(f"SELECT * FROM Order_Products WHERE o_id = {o_id} AND p_id = {p_id}")
    if len(existing_product) > 0:
        with transaction.atomic():
            new_amount = existing_product[0][2] + p_amount
            executeRaw(f"UPDATE Order_Products SET p_amount = {new_amount}, purchased_price = {purchased_price} WHERE o_id = {o_id} AND p_id = {p_id}")
            total_price += p_amount * purchased_price
            executeRaw(f"UPDATE Orders SET total_price = {total_price} WHERE o_id = {o_id}")
            response = HttpResponse("Item amount updated in basket successfully")
            response.status_code = 200
        return response
    

    with transaction.atomic():
        insert_one("Order_Products", p_id, o_id, p_amount, purchased_price)
        total_price += p_amount * purchased_price
        executeRaw(f"UPDATE Orders SET total_price = {total_price} WHERE o_id = {o_id}")
        response = HttpResponse("Item added to basket successfully")
        response.status_code = 201
    return response

def convert_to_serializable(result):
    serializable_result = []
    for row in result:
        serializable_row = []
        for value in row:
            if isinstance(value, datetime):
                serializable_row.append(value.strftime('%Y-%m-%d %H:%M:%S'))
            elif isinstance(value, Decimal):
                serializable_row.append(str(value))
            else:
                serializable_row.append(value)
        serializable_result.append(serializable_row)
    return serializable_result

def get_template_serial(request, func_name, query):
    if request.method != 'GET':
        response = HttpResponse(func_name + " only accepts GET requests")
        response.status_code = 405
        return response
    result = executeRaw(query)
    if len(result) == 0:
        response = HttpResponse(func_name + " returned none")
        response.status_code = 420
        return response
    result = convert_to_serializable(result)
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response

def get_orders(request):
    response = get_template_serial(request, 'get_orders', "select * from Orders JOIN Order_Placements ON Orders.o_id = Order_Placements.o_id")
    return response

# COMPLEX QUERY
@csrf_exempt
def get_lowest_rater_customers(request, num_customers):
    result = executeRaw(f"SELECT c.home_address, c.city, c.phone, u.u_id, u.u_id, u.u_name, u.surname, u.username, u.pwd, AVG(op.rating) FROM Users u JOIN Customers c ON u.u_id = c.u_id JOIN Order_Placements op ON c.u_id = op.u_id GROUP BY u.u_id ORDER BY AVG(op.rating) ASC LIMIT {num_customers}")
    result = convert_decimals_and_datetimes_to_str(result)
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response