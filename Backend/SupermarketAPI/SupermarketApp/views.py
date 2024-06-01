from django.shortcuts import render
from rest_framework.parsers import JSONParser
from django.views.decorators.csrf import csrf_exempt
from SupermarketApp.dao import executeRaw, get_next_id, insert_one
from django.http import HttpResponse
from django.db import transaction
import json
from decimal import Decimal

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


#WARNING: get_low_stock_products returns lowest stock product from each category
@csrf_exempt
def get_low_stock_products(request):
    if request.method != 'GET':
        response = HttpResponse("get_low_stock_products only accepts GET requests")
        response.status_code = 405
        return response
    
    result = executeRaw("""SELECT * 
                            FROM Products p1 
                            WHERE stock_amount = (
                                SELECT MIN(stock_amount) 
                                FROM Products p2 
                                WHERE p2.category = p1.category
                            );""")
    if len(result) == 0:
        response = HttpResponse("No low stock products found")
        response.status_code = 404
        return response
    
    result = convert_decimals_to_str(result)
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response

@csrf_exempt
def get_products(request):
    if request.method != 'GET':
        response = HttpResponse("get_products only accepts GET requests")
        response.status_code = 405
        return response
    
    result = executeRaw("select * from Products")
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
def get_products_with_higher_than_3_rating(request):
    if request.method != 'GET':
        response = HttpResponse("get_products only accepts GET requests")
        response.status_code = 405
        return response
    
    result = executeRaw("""SELECT p.p_id, p.stock_amount, p.category, p.price, p.p_name 
                            FROM Products p
                            JOIN Order_Products op ON p.p_id = op.p_id
                            JOIN Order_Placements opl ON op.o_id = opl.o_id
                            GROUP BY p.p_id
                            HAVING AVG(opl.rating) > 3""")
    if len(result) == 0:
        response = HttpResponse("No products found")
        response.status_code = 404
        return response
    
    result = convert_decimals_to_str(result)
    result = json.dumps(result)
    response = HttpResponse(result)
    response.status_code = 200
    return response

def convert_decimals_to_str(result):
    result = list(result)
    result = list(map(lambda x: list(x), result))
    for i in range(len(result)):
        for j in range(len(result[i])):
            if type(result[i][j]) == Decimal:
                result[i][j] = str(result[i][j])
    
    return result