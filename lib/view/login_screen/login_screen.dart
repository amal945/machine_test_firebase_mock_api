import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:machine_test_firebase/constants/constants.dart';
import 'package:machine_test_firebase/view/forgot_password_screen/forgot_password_screen.dart';
import '../../controller/login_controller/login_controller.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

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
            const Text("Login",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            kHeight20,

            /// Email Field
            TextField(
              controller: controller.emailController,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            kHeight15,

            /// Password Field
            Obx(() => TextField(
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )),
            kHeight10,

            /// Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.to(() => ForgotPasswordScreen(),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 500)),
                child: const Text("Forgot Password?",
                    style: TextStyle(color: Colors.blue)),
              ),
            ),
            kHeight20,

            /// Login Button
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.login, // Disable button when loading
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black, // Set text color
                ),
                child: controller.isLoading.value
                    ? LoadingAnimationWidget.progressiveDots(
                  color: Colors.white,
                  size: 50, // Change size for more/less dots
                )
                    : const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
            ),


            /// Sign Up Option
            kHeight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () => Get.to(() => RegisterScreen(),
                      transition: Transition.leftToRight,
                      duration: Duration(milliseconds: 500)),
                  child: const Text("Sign Up",
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
