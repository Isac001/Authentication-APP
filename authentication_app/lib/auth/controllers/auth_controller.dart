import 'package:authentication_app/auth/models/auth_model.dart';
import 'package:authentication_app/auth/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  RxString token = "".obs;
  RxInt userId = 0.obs;

  void _decodeToken() {
    if (token.value.isNotEmpty) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token.value);

      if (decodedToken.containsKey('user_id') && decodedToken['user_id'] != null) {
        userId.value = decodedToken['user_id'] as int;
      } else {
        Get.snackbar("ERROR", "ID do usuário não presente no token");
      }
    }
  }

  Future<void> login(String email, String password) async {
    try {
      AuthModel authModel = AuthModel(userEmail: email, password: password);
      Map<String, dynamic> response = await _authService.login(authModel);

      if (response.containsKey('access')) {
        token.value = response['access'];
        print("Token decodificado: ${JwtDecoder.decode(response['access'])}");

        _decodeToken();
        Get.offNamed('/home');
      } else {
        Get.snackbar("ERROR", "Erro ao autenticar.");
      }
    } catch (error) {
      Get.snackbar('ERROR', error.toString());
    }
  }
}
