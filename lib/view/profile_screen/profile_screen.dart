import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:machine_test_firebase/constants/constants.dart';
import 'package:machine_test_firebase/controller/dock_controller/dock_controller.dart';
import 'package:machine_test_firebase/controller/profile_controller/profile_controller.dart';
import 'package:machine_test_firebase/services/auth_service.dart';
import 'package:machine_test_firebase/view/login_screen/login_screen.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/app_dimension.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 90,
                  ),
                  // backgroundImage: const NetworkImage(
                  //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7uMw4_YgDiBPTfV1yRcjBcFA2SCy_PZm1Lg&s",
                  // ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return _buildShimmerText(width: 150, height: 16);
              }
              return Text(
                controller.username.value,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            }),
            Obx(() {
              if (controller.isLoading.value) {
                return _buildShimmerText(width: 150, height: 16);
              }
              return Text(
                controller.email.value,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              );
            }),
            const Text(
              "Normal User",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            kHeight50,
            // Profile Options
            Container(
              width: AppDimensions.screenWidth * 0.9,
              height: AppDimensions.screenHeight * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
                boxShadow: shadow,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildProfileOption(
                    icon: LucideIcons.package,
                    title: "My Orders",
                    onTap: () {},
                  ),
                  _buildProfileOption(
                    icon: LucideIcons.heart,
                    title: "Wishlist",
                    onTap: () {},
                  ),
                  _buildProfileOption(
                    icon: LucideIcons.mapPin,
                    title: "My Addresses",
                    onTap: () {},
                  ),
                  _buildProfileOption(
                    icon: LucideIcons.settings,
                    title: "Settings",
                    onTap: () {},
                  ),
                  _buildProfileOption(
                    icon: LucideIcons.logOut,
                    title: "Logout",
                    onTap: () {
                      Get.dialog(
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                          ),
                          child: Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.black,
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Confirm Logout",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Are you sure you want to logout?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 16),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        // Close dialog
                                        child: const Text("Cancel",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.back(); // Close dialog
                                          AuthService.logOut();
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => LoginScreen()),
                                            (route) => false,
                                          );
                                          Get.delete<DockController>();
                                        },
                                        child: const Text("Logout",
                                            style: TextStyle(
                                                color: Colors.redAccent)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ), // Adds shadow effect
                          ),
                        ),
                      );
                    },
                    isLogout: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Profile Option Tile
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isLogout ? Colors.red : Colors.white,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildShimmerText({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.grey[600]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
