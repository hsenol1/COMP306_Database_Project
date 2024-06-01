import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  final String baseUrl = '127.0.0.1:8000';

  Future<http.Response> getRequestTemplate(String endpoint) async {
    final url = Uri.parse('http://$baseUrl/$endpoint');
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);
    return response;
  }

  Future<List<Map<String, dynamic>>> fetchProductsTemplate(Future<http.Response> Function() getFunction) async {
    final response = await getFunction();

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data); // Debugging: Print the response data
      return data.map((product) {
        return {
          'id': product[0],
          'stock': product[1],
          'category': product[2],
          'price': product[3],
          'name': product[4],
          'image': 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png', // Placeholder image URL
        };
      }).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

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
    final uri = Uri.parse('http://$baseUrl/register-customer/');
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

  

  Future<http.Response> getProducts() async {
    return await getRequestTemplate('get-products/');
  }

  Future<http.Response> getLowStockProducts() async {
    return await getRequestTemplate('get-low-stock-products/');
  }

  Future<http.Response> getProductsWithHigherthan4Rating() async {
    return await getRequestTemplate('get-products-with-higher-than-4-rating/');
  }

  Future<http.Response> getTop5LowestRatedProducts() async {
    return await getRequestTemplate('get-top-5-lowest-rated-products/');
  }
  
  

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    return await fetchProductsTemplate(getProducts);
  }

  Future<List<Map<String, dynamic>>> fetchLowStockProducts() async {
    return await fetchProductsTemplate(getLowStockProducts);
  }

  Future<List<Map<String, dynamic>>> fetchProductsWithHigherthan4Rating() async {
    return await fetchProductsTemplate(getProductsWithHigherthan4Rating);
  }

  Future<List<Map<String, dynamic>>> fetchTop5LowestRatedProducts() async {
    return await fetchProductsTemplate(getTop5LowestRatedProducts);
  }


}
