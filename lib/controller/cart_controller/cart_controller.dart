import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    calculateTotalAmount();
    update();

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
        sortOutCartProducts();
      }
    } catch (e) {
      showCustomSnackBar(title: "Error", message: "$e", color: Colors.red);
    }
  }

  void sortOutCartProducts() {
    cartProductList.clear();

    for (var cart in cartList) {
      for (var cartItem in cart.products) {
        final product = allProductList.firstWhereOrNull((p) => p.id.toString() == cartItem.productId.toString());

        if (product != null) {

          int existingIndex = cartProductList.indexWhere((p) => p.product.id == product.id);
          if (existingIndex != -1) {

            cartProductList[existingIndex].quantity += cartItem.quantity;
          } else {

            cartProductList.add(CartOnlyModel(product: product, quantity: cartItem.quantity));
          }
        }
      }
    }
    calculateTotalAmount();
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