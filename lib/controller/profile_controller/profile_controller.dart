import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var username = "".obs;
  var email = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    fetchUserData();
    isLoading.value = false;

  }

  Future<void> fetchUserData() async {
    try {
      String userId =
          FirebaseAuth.instance.currentUser!.uid; // Replace with actual user ID

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        username.value = userDoc['fullName'] ?? "No Name";
        email.value = FirebaseAuth.instance.currentUser?.email ?? " ";
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
}
