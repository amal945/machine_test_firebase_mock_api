import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_firebase/controller/product_screen_controller/product_screen_controller.dart';
import 'package:machine_test_firebase/model/product_model.dart';

class BottomProductWidget extends StatelessWidget {
  final ProductModel data;
  const BottomProductWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
final controller = Get.put(ProductScreenController());
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Material(
              color: Colors.black,
              child: InkWell(
                onTap: ()async {
                  List<Map<String, dynamic>> products = [{"productId":data.id,"quantity":1}];
                await  controller.addToCart(products);
                },
                splashColor: Colors.grey[700],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart_checkout_sharp,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {

                },
                splashColor: Colors.amber[400],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Buy Now",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.flash_on,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
