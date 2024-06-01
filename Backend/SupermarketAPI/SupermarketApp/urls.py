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
    path('get-low-stock-products/', views.get_low_stock_products, name='get_low_stock_products'),
    path('get-products/', views.get_products, name='get_products'),
    path('get-products-with-higher-than-4-rating/', views.get_products_with_higher_than_4_rating, name='get_products_with_higher_than_4_rating'),
    path('get-top-5-lowest-rated-products/', views.get_top_5_lowest_rated_products, name='get_top_5_lowest_rated_products'),
    path('increase-product-quantity/', views.increase_product_quantity, name='increase_product_quantity')
]