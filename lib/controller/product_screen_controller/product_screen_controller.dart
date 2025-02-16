import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_firebase/services/cart_service.dart';

import '../../view/common_widgets/custom_snackbar.dart';

class ProductScreenController extends GetxController  {
 RxBool isLoading = false.obs;

 @override
  void onInit() {
    super.onInit();
  }


  Future<void> addToCart(List<Map<String, dynamic>> products)async{
  final response = await CartService.addToCart(products);
  if (response == 200) {
   isLoading.value = (!isLoading.value);
   showCustomSnackBar(title: "Added", message: "Product Added to Cart", color: Colors.green);
  } else {
   isLoading.value = (!isLoading.value);
   showCustomSnackBar(title: "Error", message: "Failed to add item", color: Colors.red);
  }

  }

}