import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_firebase/constants/constants.dart';
import 'package:machine_test_firebase/controller/search_controller/search_screen_controller.dart';
import '../../model/product_model.dart';
import '../home_screen/widgets/home_screen_custom_product_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchScreenController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                boxShadow: shadow,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 5,bottom: 5),
                      child:
                      Obx((){
                        return TextField(
                          onChanged: (query) => controller.searchProducts(query),
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: Visibility(
                                visible: controller.isFilterApplied.value,
                                child: IconButton(onPressed: (){
                                  controller.clearFilters();
                                }, icon: Icon(Icons.close,color: Colors.white,))),
                            border: InputBorder.none,
                            hintText: "Search products...",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                          ),
                        );
                      })
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _showFilterDialog(context, controller);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:
                            const Icon(Icons.filter_alt, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Product List
          Expanded(
            child: Obx(() {
              if (controller.filteredProductList.isEmpty) {
                return const Center(child: Text("No Result Found",style: TextStyle(color: Colors.white),));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchProducts();
                },
                color: Colors.white,
                backgroundColor: Colors.grey[850],
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.filteredProductList.length,
                  itemBuilder: (context, index) {
                    ProductModel data = controller.filteredProductList[index];
                    return CustomProductWidget(data: data);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, SearchScreenController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Filter Products",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8, // Fixed width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch widgets to full width
              children: [
                // Category Filter
                Obx(() {
                  return DropdownButton<String>(
                    dropdownColor: Colors.black,
                    isExpanded: true, // Ensure full width
                    value: controller.categories.contains(controller.selectedCategory.value)
                        ? controller.selectedCategory.value
                        : null,
                    hint: const Text("Select Category", style: TextStyle(color: Colors.white)),
                    items: controller.categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedCategory.value = value!;
                    },
                  );
                }),

                kHeight10,

                // Price Range Slider
                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price Range: \$${controller.minPrice.value} - \$${controller.maxPrice.value}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: double.infinity, // Make slider full width
                      child: RangeSlider(
                        values: RangeValues(controller.minPrice.value, controller.maxPrice.value),
                        min: 0,
                        max: 1000,
                        divisions: 10,
                        onChanged: (values) {
                          controller.minPrice.value = values.start;
                          controller.maxPrice.value = values.end;
                        },
                      ),
                    ),
                  ],
                )),

                kHeight10,

                // Rating Filter
                Obx(() => DropdownButton<double>(
                  dropdownColor: Colors.black,
                  isExpanded: true, // Make dropdown full width
                  value: controller.selectedRating.value,
                  hint: const Text("Select Minimum Rating", style: TextStyle(color: Colors.white)),
                  items: [0, 1, 2, 3, 4, 5].map((rating) {
                    return DropdownMenuItem(
                      value: rating.toDouble(),
                      child: Text("$rating ★", style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedRating.value = value!;
                  },
                )),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align buttons properly
              children: [
                TextButton(
                  onPressed: () {
                    controller.clearFilters();
                    Get.back();
                  },
                  child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: () {
                    controller.applyFilters();
                    Get.back();
                  },
                  child: const Text("Apply", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}
