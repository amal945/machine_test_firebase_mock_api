import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:machine_test_firebase/constants/app_dimension.dart';
import 'package:machine_test_firebase/constants/constants.dart';
import 'package:machine_test_firebase/controller/forgot_password_controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Forgot Password",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: () {
          Get.back();
        },),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your email and we'll send you a password reset link.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            kHeight20,
            // Email TextField
          TextField(
                controller: controller.emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.white70),
                ),
              ),
            kHeight20,
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                onPressed:
                controller.isLoading.value ? null : controller.resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black, // Set text color
                ),
                child:controller.isLoading.value
                    ? LoadingAnimationWidget.progressiveDots(
                  color: Colors.white,
                  size: 50, // Change size for more/less dots
                ) :
                const Text("Send Reset Link", style: TextStyle(fontSize: 16,color: Colors.black,fontWeight:FontWeight.bold)),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
