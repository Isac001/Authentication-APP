import 'package:authentication_app/auth/controllers/auth_controller.dart';
import 'package:authentication_app/modules/login/controllers/login_screen_controller.dart';
import 'package:get/get.dart';

class InitializerControllers {
  
  // Constructor that initializes the controllers
  InitializerControllers() {
    // Lazily initializes the AuthController when needed
    Get.lazyPut(() => AuthController());

    // Lazily initializes the LoginScreenController when needed
    Get.lazyPut(() => LoginScreenController());
  }
}
