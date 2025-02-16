import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../model/cart_product_model.dart';
import '../../model/product_model.dart';
import '../../services/cart_service.dart';
import '../../services/product_services.dart';
import '../../view/common_widgets/custom_snackbar.dart';

class CartScreenController extends GetxController {
  RxList<CartProductModel> cartList = <CartProductModel>[].obs;
  RxList<ProductModel> allProductList = <ProductModel>[].obs;
  RxList<CartOnlyModel> cartProductList = <CartOnlyModel>[].obs;
  var totalAmount = 0.0.obs;
RxBool isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = (!isLoading.value);
    await fetchCartData();
    await fetchProducts();
    sortOutCartProducts();
    isLoading.value = (!isLoading.value);
    super.onInit();
  }
  void updateQuantity(CartOnlyModel item, int newQuantity) async {
    int index = cartProductList.indexWhere((element) => element.product.id == item.product.id);
    if (index != -1) {
      cartProductList[index].quantity = newQuantity;
      cartProductList.refresh();
      calculateTotalAmount();

  final response =  await CartService.updateCartQuantity(item: item, newQuantity: newQuantity);
      if (response != 200) {
        showCustomSnackBar(title: "Error", message: "Failed to update quantity", color: Colors.red);
      }
    }
  }



  void removeFromCart(CartOnlyModel item) async {
    isLoading.value = (!isLoading.value);
    cartProductList.remove(item);
    calculateTotalAmount(); // Recalculate after removal
    update(); // Notify UI

    final response = await CartService.removeFromCart(id: item.product.id);

    if (response == 200) {
      isLoading.value = (!isLoading.value);
      showCustomSnackBar(title: "Removed", message: "Item removed from cart", color: Colors.green);
    } else {
      isLoading.value = (!isLoading.value);
      showCustomSnackBar(title: "Error", message: "Failed to remove item", color: Colors.red);
    }
  }


  fetchCartData() async {
    final response = await CartService.getCartProducts();
    if (response.isNotEmpty) {
      cartList.assignAll(response);
    }
  }

  fetchProducts() async {
    try {
      final response = await GetProductService.getAllProducts();
      if (response.isNotEmpty) {
        allProductList.assignAll(response);
        sortOutCartProducts(); // Ensure sorting is done after products are fetched
      }
    } catch (e) {
      showCustomSnackBar(title: "Error", message: "$e", color: Colors.red);
    }
  }

  void sortOutCartProducts() {
    for(int i =0;i<allProductList.length;i++){
      for(int j =0;j<cartList.length;j++){
        for(int k = 0;k < cartList[j].products.length;k++){
          final allProductId = allProductList[i].id.toString();
          final cartProductId = cartList[j].products[k].productId.toString();
          if( allProductId == cartProductId ){
           final data = CartOnlyModel(product:allProductList[i] , quantity:cartList[j].products[k].quantity);
           cartProductList.add(data);
         }
        }
      }
    }
    calculateTotalAmount(); //
  }
  void calculateTotalAmount() {
    double total = 0.0;
    for (var cartItem in cartProductList) {
      total += (cartItem.product.price ?? 0) * cartItem.quantity;
    }
    totalAmount.value = total;
  }
}

class CartOnlyModel {
  ProductModel product;
  int quantity;
  CartOnlyModel({required this.product,required this.quantity});
}