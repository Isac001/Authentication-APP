import 'package:authentication_app/auth/controllers/auth_controller.dart';
import 'package:authentication_app/modules/login/controllers/login_screen_controller.dart';
import 'package:get/get.dart';

class InitializerControllers {
  InitializerControllers() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => LoginScreenController());
  }
}
