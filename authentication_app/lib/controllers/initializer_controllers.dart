import 'package:authentication_app/auth/controllers/auth_controller.dart';
import 'package:authentication_app/modules/login/controllers/login_screen_controller.dart';
import 'package:authentication_app/modules/user/controllers/registration_user_controller.dart';
import 'package:get/get.dart';

class InitializerControllers {
  // Constructor that initializes the controllers
  InitializerControllers() {
    // Lazily initializes the AuthController when needed
    Get.lazyPut(() => AuthController(), fenix: true);

    // Lazily initializes the LoginScreenController when needed
    Get.lazyPut(() => LoginScreenController(), fenix: true);

    // Lazily initializes the RegistrationUserController when needed
    Get.lazyPut(() => RegistrationUserController(), fenix: true);
  }
}
