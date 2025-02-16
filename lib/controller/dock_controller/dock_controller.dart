import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_firebase/constants/app_dimension.dart';
import '../../view/favourite_screen/favourite_screen.dart';
import '../../view/home_screen/home_screen.dart';
import '../../view/profile_screen/profile_screen.dart';
import '../../view/search_screen/search_screen.dart';

class DockController extends GetxController {
  var index = 0.obs;
  late PageController pageController;

  var size = Size.zero.obs;
  var isWeb = false.obs;
  var dockWidth = 0.0.obs;
  var dockHeight = 0.0.obs;
  var iconSize = 0.0.obs;

  List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.person,
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      size.value = AppDimensions.screenSize;
      isWeb.value = size.value.width > 600;
      dockWidth.value = size.value.width * 0.9;
      dockHeight.value = isWeb.value ? 80 : 60;
      iconSize.value = isWeb.value ? 35 : 28;
    });
  }

  void switchPage(int newIndex) {
    index.value = newIndex;
    pageController.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
