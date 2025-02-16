import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_firebase/controller/dock_controller/dock_controller.dart';
import 'package:machine_test_firebase/view/cart_screen/cart_screen.dart';

class DockScreen extends StatelessWidget {
  const DockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DockController());
    Size size = MediaQuery.of(context).size;
    bool isWeb = size.width > 600;
    double dockWidth = isWeb ? size.width * 0.9 : size.width * 0.9;
    double dockHeight = isWeb ? 80 : 60;
    double iconSize = isWeb ? 35 : 28;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "E_CART",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(
                      () => const CartScreen(),
                  transition: Transition.downToUp,
                  duration: const Duration(milliseconds: 500),
                );
              },
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
            ),
          ],
        ),
        body: Obx(() {
          bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
          return Stack(
            children: [
              PageView(
                controller: controller.pageController,
                physics: const BouncingScrollPhysics(), // Smooth transition
                onPageChanged: (i) => controller.index.value = i,
                children: controller.pages,
              ),
              Visibility(
                visible: !isKeyboardOpen,
                child: Positioned(
                  bottom: size.height * 0.00,
                  left: !isWeb
                      ? (size.width - dockWidth) / 4.5
                      : (size.width - dockWidth) / 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    child: Container(
                      width: dockWidth,
                      height: dockHeight,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(0, 3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(controller.icons.length, (i) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: isWeb ? 8 : 4),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: controller.index.value == i
                                  ? (isWeb ? 65 : 55)
                                  : (isWeb ? 55 : 45),
                              height: controller.index.value == i
                                  ? (isWeb ? 65 : 55)
                                  : (isWeb ? 55 : 45),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  if (controller.index.value == i)
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.7),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () => controller.switchPage(i),
                                icon: Icon(
                                  controller.icons[i],
                                  size: iconSize,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
