import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_firebase/constants/constants.dart';
import 'package:machine_test_firebase/model/product_model.dart';

import '../../product_screen/product_screen.dart';

class CustomProductWidget extends StatefulWidget {
  final ProductModel data;
  const CustomProductWidget({super.key, required this.data});

  @override
  State<CustomProductWidget> createState() => _CustomProductWidgetState();
}

class _CustomProductWidgetState extends State<CustomProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () {
          Get.to(() => ProductScreen(data: widget.data),transition: Transition.downToUp,
              duration: Duration(milliseconds: 500));
        },
        child: Container(
          width: size.width / 1,
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
            color: Colors.black,
          ),
          child: Column(
            children: [
              // Product Image
              Container(
                height: size.height / 4.7,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.data.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Product Title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.data.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
kHeight10,
              // Price & Rating Row
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price
                    Text(
                      "\$${widget.data.price}",
                      style: const TextStyle(color: Colors.white),
                    ),

                    // Rating (Stars & Value)
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16), // Star icon
                        const SizedBox(width: 4), // Space
                        Text(
                          widget.data.rating.rate.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
