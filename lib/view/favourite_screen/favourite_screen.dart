import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:machine_test_firebase/constants/constants.dart';

import '../../constants/app_dimension.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppDimensions.screenWidth / 2,
                maxHeight: AppDimensions.screenHeight / 3,
              ),
              child: Lottie.asset(
                "assets/animations/Animation - 1739708341096.json",
                fit: BoxFit.contain, // Ensuring the animation fits within the container
              ),
            ),
            kHeight35,
            Text("Coming Soon....!",style: TextStyle(color: Colors.grey,fontSize: 30,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
