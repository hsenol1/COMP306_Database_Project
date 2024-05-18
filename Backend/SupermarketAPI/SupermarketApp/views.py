from django.shortcuts import render
from rest_framework.parsers import JSONParser
from django.views.decorators.csrf import csrf_exempt
from SupermarketApp.dao import executeRaw, get_next_id, insert_one
from django.http import HttpResponse
from django.db import transaction
import json

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