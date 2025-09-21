import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  static Future<Map<String, dynamic>> getProducts({
    int limit = 10,
    int skip = 0,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products?limit=$limit&skip=$skip'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<Map<String, dynamic>> getProductsByCategory(
    String category,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/category/$category'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products by category');
    }
  }

  static Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      List<dynamic> categories = json.decode(response.body);
      return categories.map((category) => category.toString()).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<Map<String, dynamic>> getProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product');
    }
  }

  static Future<Map<String, dynamic>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/search?q=$query'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to search products');
    }
  }
}
