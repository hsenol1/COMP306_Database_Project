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
    path('increase-product-quantity/', views.increase_product_quantity, name='increase_product_quantity'),
    path('decrease-product-quantity/', views.decrease_product_quantity, name='decrease_product_quantity'),
    path('delete-product/', views.delete_product, name='delete_product'),
    path('get-customers/', views.get_customers, name='get_customers'),
    path('get-one-customer-per-city/', views.get_one_customer_per_city, name='get_one_customer_per_city'),
    path('delete-customer/', views.delete_customer, name='delete_customer'),
    path('get-orders/', views.get_orders, name='get_orders'),
    path('get-products-from-order/<int:order_id>/', views.get_products_from_order, name='get-products-from-order'),
    path('get-vouchers/', views.get_vouchers, name='get_vouchers'),
    path('insert-voucher/', views.insert_voucher, name='insert_voucher'),
    path('delete-voucher/', views.delete_voucher, name='delete_voucher'),
    path('create-order/', views.create_order, name='create_order'),
    path('get-last-10-orders/', views.get_last_10_orders, name='get-last-10-orders'),
    path('login-user/', views.login_user, name='login_user'),
    path('assign-random-vouchers/',views.assign_random_vouchers, name ='assign_random_vouchers'),
    path('complete-order/', views.complete_order, name = 'complete_order')
]