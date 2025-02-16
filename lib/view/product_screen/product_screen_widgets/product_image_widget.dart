import 'package:flutter/material.dart';

class ProductDetailImageWidget extends StatelessWidget {
  final String imageUrl;

  const ProductDetailImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: size.width,
        height: size.height / 2.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
