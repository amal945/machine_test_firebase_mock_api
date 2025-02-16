import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_firebase/constants/app_dimension.dart';
import 'package:machine_test_firebase/view/home_screen/widgets/custom_category_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:machine_test_firebase/controller/home_controller/home_controller.dart';
import 'package:machine_test_firebase/model/product_model.dart';
import 'package:machine_test_firebase/view/home_screen/widgets/home_screen_custom_product_widget.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.productList.isEmpty) {
          return _buildShimmerEffect();
        }
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchProducts();
          },
          color: Colors.white,
          backgroundColor: Colors.grey[850],
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14.0, right: 12, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCategoryWidget(
                        text: 'Men',
                        imageUrl:
                            'https://rukminim2.flixcart.com/image/850/1000/xif0q/poster/q/0/b/small-asim-riaz-model-02-asim-riaz-model-poster-multicolor-photo-original-imagg58zfvghjcuk.jpeg?q=90&crop=false',
                      ),
                      CustomCategoryWidget(
                        text: "Women",
                        imageUrl:
                            "https://media.istockphoto.com/id/1294339577/photo/young-beautiful-woman.jpg?s=612x612&w=0&k=20&c=v41m_jNzYXQtxrr8lZ9dE8hH3CGWh6HqpieWkdaMAAM=",
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Container(
                        width: AppDimensions.screenWidth,
                        height: AppDimensions.screenHeight / 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 0),
                            ),
                          ],
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://images.pexels.com/photos/15817509/pexels-photo-15817509/free-photo-of-model-in-a-black-shirt-with-printed-pattern-in-front-of-a-vogue-poster.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 40,
                        right: 20,
                        child: Text(
                          "30% Off",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                        bottom: 5,
                        right: 20,
                        child: Text(
                          "On All Products",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.productList.length > 4
                      ? 4
                      : controller.productList.length,
                  itemBuilder: (context, index) {
                    ProductModel data = controller.productList[index];
                    return CustomProductWidget(data: data);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Shimmer Effect for Loading State
  Widget _buildShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[850]!,
            highlightColor: Colors.grey[700]!,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}
