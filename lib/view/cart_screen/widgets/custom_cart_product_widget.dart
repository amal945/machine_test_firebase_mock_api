import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_firebase/constants/constants.dart';

import '../../../controller/cart_controller/cart_controller.dart';
class CustomCartProductWidget extends StatelessWidget {
  CartOnlyModel data;
   CustomCartProductWidget({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartScreenController>();
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        decoration:  BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: size.height / 5.5,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(data.product.image)),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                    ),
                    color: Colors.black, // Placeholder color
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 3),
                      child: SizedBox(
                        width: size.width / 2, // Restrict width
                        child: Text(
                          data.product.title,
                          maxLines: 3, // Restrict to 1 line
                          overflow: TextOverflow.ellipsis, // Add "..." for overflow
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              "\$ ${data.product.price}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          kWidth20,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: shadow,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_drop_down, size: 30, color: Colors.white),
                                  onPressed: () {
                                    if (data.quantity > 1) {
                                      controller.updateQuantity(data, data.quantity - 1);
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                  child: Center(
                                    child: Text(
                                      data.quantity.toString(),
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_drop_up, size: 30, color: Colors.white),
                                  onPressed: () {
                                    controller.updateQuantity(data, data.quantity + 1);
                                  },
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {

                      },
                      splashColor: Colors.grey.shade100,
                      child: Container(
                        height: size.height / 19,
                        child: const Center(
                          child: Text(
                            "Buy now",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.red,
                    borderRadius: const BorderRadius.only(

                      bottomRight: Radius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.removeFromCart(data);
                      },
                      splashColor: Colors.redAccent,
                      child: Container(
                        height: size.height / 19,
                        child: const Center(
                          child: Text(
                            "Remove",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}