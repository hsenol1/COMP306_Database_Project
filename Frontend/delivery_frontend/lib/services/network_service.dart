import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  //web: 127.0.0.1:8000
  //android emul: 10.0.2.2:8000
  final String baseUrl = '127.0.0.1:8000';

  Future<http.Response> getRequestTemplate(String endpoint) async {
    final url = Uri.parse('http://$baseUrl/$endpoint');
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);
    return response;
  }

  Future<http.Response> getRequestWithIdTemplate(String endpoint, String id) async {
    final url = Uri.parse('http://$baseUrl/$endpoint/$id/');
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);
    return response;
  }

  Future<List<Map<String, dynamic>>> fetchProductsTemplate(
      Future<http.Response> Function() getFunction) async {
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
          'image': 'assets/' + product[4] + '.png', // Placeholder image URL
        };
      }).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<http.Response> deleteTemplate(String endpoint, String itemId) async {
    final url = Uri.parse('http://$baseUrl/$endpoint/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': itemId,
      }),
    );
    return response;
  }

  Future<List<Map<String, dynamic>>> fetchCustomersTemplate(
      Future<http.Response> Function() getFunction) async {
    final response = await getFunction();

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data); // Debugging: Print the response data
      return data.map((customer) {
        return {
          'id': customer[3],
          'name': customer[5],
          'surname': customer[6],
          'username': customer[7],
          'password': customer[8],
          'city': customer[1],
          'home_address': customer[0],
          'phone': customer[2],
        };
      }).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }

  Future<List<Map<String, dynamic>>> fetchOrderTemplate(
      Future<http.Response> Function() getFunction) async {
    final response = await getFunction();

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data); // Debugging: Print the response data
      return data.map((order) {
        return {
          'id': order[0],
          'customer_id': order[5],
          'total_price': order[2],
          'date': order[3],
        };
      }).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<List<Map<String, dynamic>>> fetchVouchersTemplate(
      Future<http.Response> Function() getFunction) async {
    final response = await getFunction();

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data); // Debugging: Print the response data
      return data.map((voucher) {
        return {
          'id': voucher[0],
          'discount_rate': voucher[1],
          'name': voucher[2],
        };
      }).toList();
    } else {
      throw Exception('Failed to load vouchers');
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
    final url = Uri.parse('http://$baseUrl/login-user/');
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
    final uri = Uri.parse('http://$baseUrl/get-categories/');
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

  Future<http.Response> addProductToBucket(
      String username, String productName) async {
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

  Future<http.Response> getBucket(int uid) async {
    final url = Uri.parse('http://$baseUrl/get-bucket/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'uid': uid,
      }),
    );
    return response;
  }

  Future<http.Response> completeOrder(
      int uid, String paymentMethod, int vid) async {
    final url = Uri.parse('http://$baseUrl/complete-order/');
    final response;
    if (vid == -1) {
      response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'uid': uid,
          'paymentMethod': paymentMethod,
        }),
      );
    } else {
      response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'uid': uid, 'paymentMethod': paymentMethod, 'vid': vid}),
      );
    }
    return response;
  }

  Future<http.Response> getOrderHistory(int uid) async {
    final url = Uri.parse('http://$baseUrl/get-order-history/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'uid': uid,
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

  Future<List<Map<String, dynamic>>>
      fetchProductsWithHigherthan4Rating() async {
    return await fetchProductsTemplate(getProductsWithHigherthan4Rating);
  }

  Future<List<Map<String, dynamic>>> fetchTop5LowestRatedProducts() async {
    return await fetchProductsTemplate(getTop5LowestRatedProducts);
  }

  Future<http.Response> increaseProductQuantity(
      String productId, int quantity) async {
    final url = Uri.parse('http://$baseUrl/increase-product-quantity/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'p_id': productId,
        'quantity': quantity,
      }),
    );
    return response;
  }

  Future<http.Response> decreaseProductQuantity(
      String productId, int quantity) async {
    final url = Uri.parse('http://$baseUrl/decrease-product-quantity/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'p_id': productId,
        'quantity': quantity,
      }),
    );
    return response;
  }

  Future<http.Response> deleteProduct(String productId) async {
    return await deleteTemplate('delete-product', productId);
  }

  Future<http.Response> deleteCustomer(String customerId) async {
    return await deleteTemplate('delete-customer', customerId);
  }

  Future<http.Response> deleteVoucher(String voucherId) async {
    return await deleteTemplate('delete-voucher', voucherId);
  }

  Future<http.Response> getCustomers() async {
    return await getRequestTemplate('get-customers');
  }

  Future<http.Response> getOneCustomerPerCity() async {
    return await getRequestTemplate('get-one-customer-per-city');
  }

  Future<List<Map<String, dynamic>>> fetchCustomers() async {
    return await fetchCustomersTemplate(getCustomers);
  }

  Future<List<Map<String, dynamic>>> fetchOneCustomerPerCity() async {
    return await fetchCustomersTemplate(getOneCustomerPerCity);
  }

  Future<http.Response> getOrders() async {
    return await getRequestTemplate('get-orders');
  }

  Future<http.Response> getProductsFromOrder(String orderId) async {
    return await getRequestTemplate('get-products-from-order/$orderId');
  }

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    return await fetchOrderTemplate(getOrders);
  }

  Future<List<Map<String, dynamic>>> fetchProductsFromOrder(
      String orderId) async {
    final response = await getProductsFromOrder(orderId);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data); // Debugging: Print the response data
      return data.map((product) {
        return {
          'id': product[0],
          'name': product[4],
          'quantity': product[5],
          'price': product[6],
          'image': 'assets/' + product[4] + '.png',
        };
      }).toList();
    } else {
      throw Exception('Failed to load products from order');
    }
  }

  Future<http.Response> getVouchers() async {
    return await getRequestTemplate('get-vouchers');
  }

  Future<http.Response> insertVoucher(
      int discountRate, String voucherName) async {
    final url = Uri.parse('http://$baseUrl/insert-voucher/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'discount_rate': discountRate,
        'v_name': voucherName,
      }),
    );
    return response;
  }

  Future<List<Map<String, dynamic>>> fetchVouchers() async {
    return await fetchVouchersTemplate(getVouchers);
  }

  Future<http.Response> giveVoucherToOneCustomerPerCity(
      String voucherId) async {
    return await getRequestTemplate(
        'give-voucher-to-one-customer-per-city/$voucherId');
  }

  Future<http.Response> assignRandomVouchers(String voucherId) async {
    return await getRequestTemplate('assign-random-vouchers/$voucherId');
  }

  Future<List<Map<String, dynamic>>> fetchCustomersWhoGaveTheLowestRatings(String voucherId) async {
    return await fetchCustomersTemplate(() => getRequestWithIdTemplate('get-customer-lowest', voucherId));
  }


}
