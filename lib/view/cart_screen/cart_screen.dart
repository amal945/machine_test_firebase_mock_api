import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_firebase/constants/constants.dart';
import 'package:shimmer/shimmer.dart';
import '../../controller/cart_controller/cart_controller.dart';
import 'widgets/custom_cart_product_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartScreenController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        title: const Text("Cart", style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value){
                return ListView.builder(
                  itemCount: 5, // Placeholder count
                  itemBuilder: (context, index) {
                    return _buildShimmerPlaceholder(size);
                  },
                );
              }
            else  if (controller.cartProductList.isEmpty) {
               return Center(child: Text("No Added Data",style: TextStyle(color: Colors.white),),);
              }else{
                return ListView.separated(
                  itemCount: controller.cartProductList.length,
                  itemBuilder: (context, index) {
                    final product = controller.cartProductList[index];
                    return CustomCartProductWidget(data: product);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                );
              }
            }),
          ),
          _buildCheckoutSection(controller),
        ],
      ),
    );
  }

  // Checkout Section
  Widget _buildCheckoutSection(CartScreenController controller) {
    return Obx((){
      return  Visibility(
        visible: controller.cartProductList.isNotEmpty,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.black,
            border: Border(
              top: BorderSide(color: Colors.white24, width: 1),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  Text(
                    "\$${controller.totalAmount.value.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            kHeight10,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Checkout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
  Widget _buildShimmerPlaceholder(Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[600]!,
        child: Container(
          height: size.height / 5.5,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
