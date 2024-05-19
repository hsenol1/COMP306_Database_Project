from django.urls import path
from . import views

urlpatterns = [
    path('register-customer/', views.register_customer, name='register_customer'),
    path('get-categories/', views.get_categories, name='get_categories'),
    path('get-products-by-category/', views.get_products_by_category, name='get_products_by_category'),
]