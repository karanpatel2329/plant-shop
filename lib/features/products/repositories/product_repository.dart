import 'package:http/http.dart' as http;
import 'package:thence/core/api_url.dart';
import 'dart:convert';

import 'package:thence/features/products/models/product_model.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(ApiRoutes.getProductList));
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
