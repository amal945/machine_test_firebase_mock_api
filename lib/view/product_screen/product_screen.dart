import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_firebase/model/product_model.dart';
import 'package:machine_test_firebase/view/product_screen/product_screen_widgets/product_bottom_widget.dart';
import 'package:machine_test_firebase/view/product_screen/product_screen_widgets/product_description_widget.dart';
import 'product_screen_widgets/product_image_widget.dart';
class ProductScreen extends StatelessWidget {
  final ProductModel data;
  const ProductScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: const Text('Product Details',style: TextStyle(color: Colors.white),),backgroundColor: Colors.transparent,),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ProductDetailImageWidget(imageUrl: data.image),
                ProductDescriptionWidget(data: data),
              ],
            ),
          ),
          BottomProductWidget(data: data),
        ],
      ),
    );
  }
}
