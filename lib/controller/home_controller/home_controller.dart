import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_firebase/services/product_services.dart';
import 'package:machine_test_firebase/view/common_widgets/custom_snackbar.dart';
import '../../model/product_model.dart';


class HomeController extends GetxController {
  RxList<ProductModel> productList = <ProductModel>[].obs;


  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    try {
      final response = await GetProductService.getAllProducts();
      if (response.isNotEmpty) {
        productList.assignAll(response);
      } else {

      }
    } catch (e) {
      showCustomSnackBar(title: "Error", message: "$e", color: Colors.red);
    }
  }
}
