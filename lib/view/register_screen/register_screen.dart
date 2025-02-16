import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:machine_test_firebase/constants/constants.dart';
import '../../controller/register_controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Register",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            kHeight20,
            /// Full Name Field
            TextField(
              controller: controller.fullNameController,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                labelText: "Full Name",
                labelStyle: const TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.person, color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              keyboardType: TextInputType.name,
            ),
            kHeight15,


            /// Email Field
            TextField(
              controller: controller.emailController,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: const TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.email, color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            kHeight15,

            /// Password Field
            Obx(() => TextField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )),
            kHeight15,

            /// Confirm Password Field
            Obx(() => TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: !controller.isConfirmPasswordVisible.value,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          controller.isConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )),
            kHeight20,

            /// Register Button
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                    onPressed:
                        controller.isLoading.value ? null : controller.register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black, // Set text color
                ),
                    child:controller.isLoading.value
                        ? LoadingAnimationWidget.progressiveDots(
                      color: Colors.white,
                      size: 50, // Change size for more/less dots
                    ) :
                        const Text("Register", style: TextStyle(fontSize: 16,color: Colors.black,fontWeight:FontWeight.bold)),
                  )),
            ),

            kHeight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",
                    style: TextStyle(color: Colors.white)),
                TextButton(
                  onPressed: () => Get.back(), // Go back to Login screen
                  child:
                      const Text("Login", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
