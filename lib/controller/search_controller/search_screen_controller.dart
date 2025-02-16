import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/product_model.dart';
import '../../services/product_services.dart';
import '../../view/common_widgets/custom_snackbar.dart';

class SearchScreenController extends GetxController {
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> filteredProductList = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  RxString searchQuery = "".obs;
  RxString selectedCategory = "".obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 1000.0.obs;
  RxDouble selectedRating = 0.0.obs;
  RxBool isFilterApplied = false.obs;
  List<String> categories = ["All","women's clothing", "men's clothing", "jewelery", "electronics", ];

  @override
  void onInit() async{
   await fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    isLoading.value = (!isLoading.value);
    try {
      final response = await GetProductService.getAllProducts();
      if (response.isNotEmpty) {
        productList.assignAll(response);
        filteredProductList.assignAll(response);
        isLoading.value = (!isLoading.value);
      }else{
        isLoading.value = (!isLoading.value);
      }
    } catch (e) {
      isLoading.value = (!isLoading.value);
      showCustomSnackBar(title: "Error", message: "$e", color: Colors.red);
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    filterProducts();
  }

  void applyFilters() {
    isFilterApplied.value = true;
    filterProducts();
  }
  void clearFilters() {
    searchQuery.value = "";
    selectedCategory.value = "";
    minPrice.value = 0.0;
    maxPrice.value = 1000.0;
    selectedRating.value = 0.0;
    filteredProductList.assignAll(productList);
    isFilterApplied.value = false;
  }


  void filterProducts() {
    isLoading.value = (!isLoading.value);
    List<ProductModel> tempList = productList.where((product) {
      bool matchesQuery = searchQuery.isEmpty || product.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      bool matchesCategory = selectedCategory.isEmpty || selectedCategory.value == "All" || product.category == selectedCategory.value;
      bool matchesPrice = product.price >= minPrice.value && product.price <= maxPrice.value;
      bool matchesRating = product.rating.rate >= selectedRating.value;
      return matchesQuery && matchesCategory && matchesPrice && matchesRating;
    }).toList();

    filteredProductList.assignAll(tempList);
    isLoading.value = (!isLoading.value);
  }
}
