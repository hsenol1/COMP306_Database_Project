from django.shortcuts import render
from rest_framework.parsers import JSONParser
from django.views.decorators.csrf import csrf_exempt
from SupermarketApp.dao import executeRaw, get_next_id, insert_one
from django.http import HttpResponse
from django.db import transaction
import json
from decimal import Decimal
from datetime import datetime


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
def get_categories(request):
    if request.method != 'GET':
        response = HttpResponse("get_categories only accepts GET requests")
        response.status_code = 405
        return response
    result = executeRaw("select distinct category from Products")
    if len(result) == 0:
        response = HttpResponse("No categories found")
        response.status_code = 404
        return response
    result = map(lambda x: x[0], result)
    result = json.dumps(list(result))
    response = HttpResponse(result)
    response.status_code = 200
    return response

@csrf_exempt
def get_products_by_category(request):
    if request.method != 'GET':
        response = HttpResponse("get_products_by_category only accepts GET requests")
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
        response.status_code = 404
        return response
    
    result = convert_decimals_to_str(result)
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response

@csrf_exempt
def get_products_by_search(request):
    if request.method != 'GET':
        response = HttpResponse("get_products_by_search only accepts GET requests")
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
        response.status_code = 404
        return response
    result = convert_decimals_to_str(result)
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response

@csrf_exempt
def is_user_admin_by_username(request):
    if request.method != 'GET':
        response = HttpResponse("is_user_admin_by_username only accepts GET requests")
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
        response.status_code = 404
        return response
    result = convert_decimals_to_str(result)
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
    if request.method != 'GET':
        response = HttpResponse("get_user_data_by_username only accepts GET requests")
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
        response.status_code = 404
        return response
    result = convert_decimals_to_str(result)
    result = result[0]
    user_id = result[0]
    admin_result = executeRaw(f"select * from Admins where u_id = {user_id}")
    if len(admin_result) == 0:
        response = HttpResponse("User is not an admin")
        response.status_code = 404
        return response
    result.append(admin_result[0])
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response

@csrf_exempt
def get_customer_data_by_username(request):
    if request.method != 'GET':
        response = HttpResponse("get_user_data_by_username only accepts GET requests")
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
        response.status_code = 404
        return response
    result = convert_decimals_to_str(result)
    result = result[0]
    user_id = result[0]
    customer_result = executeRaw(f"select * from Customers where u_id = {user_id}")
    if len(customer_result) == 0:
        response = HttpResponse("User is not a customer")
        response.status_code = 404
        return response
    result.append(customer_result[0])
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response



def get_template(request, func_name, query):
    if request.method != 'GET':
        response = HttpResponse(func_name + " only accepts GET requests")
        response.status_code = 405
        return response
    result = executeRaw(query)
    if len(result) == 0:
        response = HttpResponse(func_name + " returned none")
        response.status_code = 404
        return response
    result = convert_decimals_to_str(result)
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response



@csrf_exempt
def delete_template(request, table_name, id_field, delete_query):
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
    existing_object_result = executeRaw(f"select * from {table_name} where {id_field} = {object_id}")
    if len(existing_object_result) == 0:
        response = HttpResponse(f"{table_name} not found")
        response.status_code = 404
        return response
    with transaction.atomic():
        executeRaw(delete_query, [object_id])
    response = HttpResponse(f"{table_name} deleted successfully")
    response.status_code = 200
    return response
  


@csrf_exempt
def get_products(request):
    response = get_template(request, 'get_products', "select * from Products")
    return response



#WARNING: get_low_stock_products returns lowest stock product from each category
@csrf_exempt
def get_low_stock_products(request):
    response = get_template(request, 'get_low_stock_products', """SELECT * 
                                                                    FROM Products p1 
                                                                    WHERE stock_amount = (
                                                                        SELECT MIN(stock_amount) 
                                                                        FROM Products p2 
                                                                        WHERE p2.category = p1.category
                                                                        );""")
    return response



@csrf_exempt
def get_products_with_higher_than_4_rating(request):
    response = get_template(request, 'get_products_with_higher_than_4_rating', """SELECT p.p_id, p.stock_amount, p.category, p.price, p.p_name 
                                                                                    FROM Products p
                                                                                    JOIN Order_Products op ON p.p_id = op.p_id
                                                                                    JOIN Order_Placements opl ON op.o_id = opl.o_id
                                                                                    GROUP BY p.p_id
                                                                                    HAVING AVG(opl.rating) > 4""")
    return response



@csrf_exempt
def get_top_5_lowest_rated_products(request):
    response = get_template(request, 'get_top_5_lowest_rated_products', """SELECT p.p_id, p.stock_amount, p.category, p.price, p.p_name
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
        executeRaw(f"UPDATE Products SET stock_amount = stock_amount - {quantity} WHERE p_id = {p_id}")
    response = HttpResponse("Product quantity decreased successfully")
    response.status_code = 200
    return response



@csrf_exempt
def get_customers(request):
    response = get_template(request, 'get_customers', "select * from Customers")
    return response



@csrf_exempt
def get_one_customer_per_city(request):
    response = get_template(request, 'get_one_customer_per_city', """SELECT *
                                                                            FROM Customers
                                                                            GROUP BY city
                                                                            LIMIT 1;""")
    return response




@csrf_exempt
def get_orders(request):
    response = get_template(request, 'get_orders', "select * from orders")
    return response



@csrf_exempt
def get_products_from_order(request):
  if request.method != 'GET':
    response = HttpResponse("get_products_from_order only accepts GET requests")
    response.status_code = 405
    return response
  value = JSONParser().parse(request)
  if "order_id" not in value:
    response = HttpResponse("order_id not found in request body")
    response.status_code = 400
    return response
  order_id = value["order_id"]
  query = f"""
            SELECT p.p_id, p.stock_amount, p.category, op.purchased_price, p.p_name
            FROM Products p
            INNER JOIN Order_Products op ON p.p_id = op.p_id
            WHERE op.o_id = {order_id};
            """
  return get_template(request, "get_products_from_order", query)



@csrf_exempt
def get_vouchers(request):
    response = get_template(request, 'get_vouchers', "select * from vouchers")
    return response



@csrf_exempt
def insert_voucher(request):
  if request.method != 'POST':
    response = HttpResponse("insert_voucher only accepts POST requests")
    response.status_code = 405
    return response
  value = JSONParser().parse(request)
  required_fields = ["discount_rate", "v_name"]
  for field in required_fields:
    if field not in value:
      response = HttpResponse(f"Missing field: {field}")
      response.status_code = 400
      return response
  discount_rate = value["discount_rate"]
  v_name = value["v_name"]
  if discount_rate < 1 or discount_rate > 100:
    response = HttpResponse("Discount rate must be between 1 and 100")
    response.status_code = 400
    return response
  v_id = get_next_id("Vouchers", "v_id")
  with transaction.atomic():
    insert_one("Vouchers", v_id, discount_rate, v_name)
  response = HttpResponse("Voucher created successfully")
  response.status_code = 201
  return response



@csrf_exempt
def delete_product(request):
    return delete_template(request, "Products", "p_id", f"DELETE FROM Products WHERE p_id = %s")

@csrf_exempt
def delete_customer(request):
    return delete_template(request, "Customers", "u_id", f"DELETE FROM Customers WHERE u_id = %s")

@csrf_exempt
def delete_voucher(request):
    return delete_template(request, "Vouchers", "v_id", f"DELETE FROM Vouchers WHERE v_id = %s")


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
                purchased_price = product["purchased_price"]
                ## executeRaw(f"INSERT INTO Order_Products (p_id, o_id, p_amount, purchased_price) VALUES ({p_id}, {o_id}, {p_amount}, {purchased_price})")
                insert_one("Order_Products",p_id,o_id,p_amount, purchased_price)
                total_price += p_amount * purchased_price

        executeRaw(f"UPDATE Orders SET total_price = {total_price} WHERE o_id = {o_id}")
        
        # Create Order_Placement
        v_id = value["voucher_id"]
        rating = value["rating"]
        if v_id is None:
            v_id = get_next_id("Vouchers", "v_id")  # 
        if rating is None:
            rating = 5  # default 

        executeRaw(f"INSERT INTO Order_Placements (u_id, v_id, o_id, rating) VALUES ({u_id}, {v_id}, {o_id}, {rating})")

           
    response = HttpResponse("Order created successfully")
    response.status_code = 201
    return response
        




def convert_decimals_to_str(result):
    result = list(result)
    result = list(map(lambda x: list(x), result))
    for i in range(len(result)):
        for j in range(len(result[i])):
            if type(result[i][j]) == Decimal:
                result[i][j] = str(result[i][j])
    
    return result