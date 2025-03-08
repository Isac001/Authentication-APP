import 'package:authentication_app/auth/models/auth_model.dart';
import 'package:authentication_app/auth/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthController extends GetxController {
  // Instance of AuthService to handle authentication requests
  final AuthService _authService = AuthService();

  // Observable variables for storing the authentication token and user ID
  RxString token = "".obs;
  RxInt userId = 0.obs;

  // Method to decode the JWT token and extract user ID
  void _decodeToken() {
    // Check if the token is not empty before decoding
    if (token.value.isNotEmpty) {
      // Decode the token to retrieve user data
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token.value);

      // Verify if the decoded token contains a valid user ID
      if (decodedToken.containsKey('user_id') && decodedToken['user_id'] != null) {
        userId.value = decodedToken['user_id'] as int;
      } else {
        // Show an error message if user ID is not present in the token
        Get.snackbar("ERROR", "ID do usuário não presente no token");
      }
    }
  }

  // Method to handle user login process
  Future<void> login(String email, String password) async {
    try {
      // Create an authentication model with provided email and password
      AuthModel authModel = AuthModel(userEmail: email, password: password);

      // Send login request to the authentication service and receive response
      Map<String, dynamic> response = await _authService.login(authModel);

      // Check if the response contains an access token
      if (response.containsKey('access')) {
        // Store the token in the observable variable
        token.value = response['access'];

        // Decode the token to extract user information
        _decodeToken();

        // Navigate to the home screen upon successful login
        Get.offNamed('/home');
      } else {
        // Show an error message if authentication fails
        Get.snackbar("ERROR", "Erro ao autenticar.");
      }
    } catch (error) {
      // Handle exceptions and display error messages
      Get.snackbar('ERROR', error.toString());
    }
  }
}
