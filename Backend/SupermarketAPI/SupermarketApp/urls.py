from django.urls import path
from . import views

urlpatterns = [
    path('register-customer/', views.register_customer, name='register_customer'),
    path('get-categories/', views.get_categories, name='get_categories'),
    path('get-products-by-category/', views.get_products_by_category, name='get_products_by_category'),
    path('get-products-by-search/', views.get_products_by_search, name='get_products_by_search'),
    path('is-user-admin-by-username/', views.is_user_admin_by_username, name='is_user_admin_by_username'),
    path('get-admin-data-by-username/', views.get_admin_data_by_username, name='get_admin_data_by_username'),
    path('get-customer-data-by-username/', views.get_customer_data_by_username, name='get_customer_data_by_username'),
]