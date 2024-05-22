import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  final String baseUrl;

  NetworkService({required this.baseUrl});

  Future<http.Response> register(String name, String surname, String username,
      String password, String city, String address, String phoneNumber) async {
    final url = Uri.parse('$baseUrl/register-customer/');
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

  Future<http.Response> login(String username,
      String password) async {
        final queryParameters = {
        'username': username,
        'pwd': password,
        };
        final uri = Uri.http(baseUrl, '/login-customer/', queryParameters);
        final headers = {'Content-Type': 'application/json'};
        final response = await http.get(uri, headers: headers);
        return response;
  }

  Future<http.Response> getCategories() async {
        final uri = Uri.http(baseUrl, '/categories/');
        final headers = {'Content-Type': 'application/json'};
        final response = await http.get(uri, headers: headers);
        return response;
  }
}
