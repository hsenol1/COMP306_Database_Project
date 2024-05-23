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
    final uri = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8000,
        path: '/login-customer/',
        queryParameters: {
          'username': username,
          'pwd': password,
        }
    );
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(uri, headers: headers);
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
    final uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8000,
      path: '/get-products-by-category/',
      queryParameters: {
          'category': category,
        }
    );
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(uri, headers: headers);
    return response;
  }

  Future<http.Response> getProductsBySearch(String searchQuery) async {
    final uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8000,
      path: '/get-products-by-search/',
      queryParameters: {
          'search': searchQuery,
        }
    );
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(uri, headers: headers);
    return response;
  }
}
