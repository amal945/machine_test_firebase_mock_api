import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:machine_test_firebase/constants/app_dimension.dart';
import 'package:machine_test_firebase/constants/constants.dart';
import 'package:machine_test_firebase/controller/splash_controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppDimensions.screenHeight/2,),
              Icon(Icons.shopping_cart_rounded,color: Colors.white,size: 120,),
              Expanded(child: kHeight5),
              LoadingAnimationWidget.progressiveDots(
                color: Colors.white,
                size: 50, // Change size for more/less dots
              ),
            ],
          ),
        ),
      ),
    );
  }
}
