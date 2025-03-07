import 'package:authentication_app/auth/controllers/auth_controller.dart';
import 'package:authentication_app/auth/models/auth_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreenController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool passwordVisible = false.obs;

  RxBool stayConnected = false.obs;

  void togglePasswordVisiblility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    passwordVisible.value = false;
    stayConnected.value = false;
  }

  Future<void> saveLoginData() async {
    if (stayConnected.value) {
      await GetStorage().write('user_email', emailController.text);
      await GetStorage().write('password', passwordController);
    } else {
      await GetStorage().remove('user_email');
      await GetStorage().remove('password');
    }
  }

  Future<void> submit() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("ERROR", "Preencha os campos com email e senha");
      return;
    }

    try {
      AuthModel authModel = AuthModel(
          userEmail: emailController.text, password: passwordController.text);

      await _authController.login(authModel.userEmail!, authModel.password!);
      await saveLoginData();
    } catch (error) {
      Get.snackbar("ERROR", error.toString());
    }
  }
}
