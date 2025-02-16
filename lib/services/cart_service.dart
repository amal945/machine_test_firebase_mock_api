import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/url.dart';
import '../controller/cart_controller/cart_controller.dart';
import '../model/cart_product_model.dart';

class CartService {
  static Future<List<CartProductModel>> getCartProducts() async {
    try {
      final response = await http.get(Uri.parse(Urls.getAllCart));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);

        List<CartProductModel> cartList =
            jsonData.map((item) => CartProductModel.fromJson(item)).toList();

        return cartList;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> updateCartQuantity(
      {required CartOnlyModel item, required int newQuantity}) async {
    try {
      final response = await http.patch(
        Uri.parse("${Urls.baseUrl}carts/${item.product.id}"),
        body: jsonEncode({"quantity": newQuantity}),
        headers: {"Content-Type": "application/json"},
      );
      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  static Future<int> removeFromCart({required int id}) async {
    try {
      final response =
          await http.delete(Uri.parse("${Urls.baseUrl}carts/$id"));
      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

static  Future<int> addToCart(List<Map<String, dynamic>> products) async {
    final Map<String, dynamic> data = {
      "userId": 2,
      "date": DateTime.now().toIso8601String().split('T')[0],
      "products": products,
    };

    try {
      final response = await http.post(
        Uri.parse("${Urls.baseUrl}carts"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        return response.statusCode;

      } else {
        return response.statusCode;

      }
    } catch (e) {

      return 500;
    }
  }
}
