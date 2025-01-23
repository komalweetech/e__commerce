import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRepository {
  final String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      // Check for successful status code
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Ensure products field exists and is a list
        if (data.containsKey('products') && data['products'] is List) {
          return (data['products'] as List)
              .map((product) => Product.fromJson(product))
              .toList();
        } else {
          throw Exception('Invalid response format: "products" field missing or invalid');
        }
      } else {
        throw Exception('Failed to load products: HTTP ${response.statusCode}');
      }
    } catch (e) {
      // Log the error for debugging purposes
      print('Error fetching products: $e');
      throw Exception('Failed to load products: $e');
    }
  }
}
