import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machine_test_firebase/constants/url.dart';
import '../model/product_model.dart';

class GetProductService {
  static Future<List<ProductModel>> getAllProducts() async{
      try {
        final response = await http.get(Uri.parse(Urls.getAllProduct));

        if (response.statusCode == 200) {

          List<dynamic> jsonData = json.decode(response.body);

          return jsonData.map((item) => ProductModel.fromJson(item)).toList();

        } else {

         return [];
        }
      } catch (e) {
        rethrow;
      }

  }
}