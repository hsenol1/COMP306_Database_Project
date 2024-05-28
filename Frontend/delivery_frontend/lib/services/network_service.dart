import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  final String baseUrl;

  NetworkService({required this.baseUrl});

  Future<http.Response> register(String name, String surname, String username,
      String password, String city, String address, String phoneNumber) async {
    final url = Uri.parse('http://$baseUrl/register-customer/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'u_name': name,
        'surname': surname,
        'username': username,
        'pwd': password,
        'city': city,
        'home_address': address,
        'phone': phoneNumber,
      }),
    );
    return response;
  }

  Future<http.Response> login(String username, String password) async {
    final url = Uri.parse('http://$baseUrl/login-customer/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
          'username': username,
          'pwd': password,
      }),
    );
    return response;
  }
  
  Future<http.Response> getCategories() async {
    final uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8000,
      path: '/get-categories/',
    );
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(uri, headers: headers);
    return response;
  }

  Future<http.Response> getProductsByCategory(String category) async {
    final url = Uri.parse('http://$baseUrl/get-products-by-category/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
          'category': category,
      }),
    );
    return response;
  }

  Future<http.Response> getProductsBySearch(String searchQuery) async {
    final url = Uri.parse('http://$baseUrl/get-products-by-search/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
          'search': searchQuery,
      }),
    );
    return response;
  }

  Future<http.Response> addProductToBucket(String username, String productName) async {
    final url = Uri.parse('http://$baseUrl/add-product-to-bucket/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
          'username': username,
          'productName': productName,
      }),
    );
    return response;
  }

  Future<http.Response> deleteBucket(String username) async {
    final url = Uri.parse('http://$baseUrl/delete-bucket/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
          'username': username,
      }),
    );
    return response;
  }

  Future<http.Response> getBucket(String username) async {
    final url = Uri.parse('http://$baseUrl/get-bucket/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
          'username': username,
      }),
    );
    return response;
  }
  
  Future<http.Response> createOrder(String username, String paymentMethod) async {
    final url = Uri.parse('http://$baseUrl/create-order/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
          'username': username,
          'paymentMethod': paymentMethod,
      }),
    );
    return response;
  }

  Future<http.Response> getOrderHistory(String username) async {
    final url = Uri.parse('http://$baseUrl/get-order-history/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
          'username': username,
      }),
    );
    return response;
  }

  Future<http.Response> getLowStockProducts() async {
    final url = Uri.parse('http://$baseUrl/get-low-stock-products/');
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);
    return response;
  }
}
