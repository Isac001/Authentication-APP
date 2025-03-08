import 'package:authentication_app/auth/controllers/auth_controller.dart';
import 'package:authentication_app/auth/models/auth_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreenController extends GetxController {
  
  // Instance of AuthController to handle authentication
  final AuthController _authController = Get.find<AuthController>();

  // Controllers for email and password input fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Observable variable to track password visibility
  RxBool passwordVisible = false.obs;

  // Observable variable to track "Stay Connected" checkbox status
  RxBool stayConnected = false.obs;

  // Method to toggle password visibility
  void togglePasswordVisiblility() {
    passwordVisible.value = !passwordVisible.value;
  }

  // Method to clear input fields and reset observable values
  void clearFields() {
    emailController.clear();
    passwordController.clear();
    passwordVisible.value = false;
    stayConnected.value = false;
  }

  // Method to save or remove login data based on "Stay Connected" option
  Future<void> saveLoginData() async {
    if (stayConnected.value) {
      await GetStorage().write('user_email', emailController.text);
      await GetStorage().write('password', passwordController);
    } else {
      await GetStorage().remove('user_email');
      await GetStorage().remove('password');
    }
  }

  // Method to validate and submit login credentials
  Future<void> submit() async {
    // Check if email and password fields are not empty
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("ERROR", "Preencha os campos com email e senha");
      return;
    }

    try {
      // Create an authentication model with the provided credentials
      AuthModel authModel = AuthModel(
          userEmail: emailController.text, password: passwordController.text);

      // Attempt login through AuthController
      await _authController.login(authModel.userEmail!, authModel.password!);

      // Save login data if "Stay Connected" is enabled
      await saveLoginData();
    } catch (error) {
      // Display error message in case of failure
      Get.snackbar("ERROR", error.toString());
    }
  }
}
