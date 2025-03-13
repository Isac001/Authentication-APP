import 'package:authentication_app/modules/user/models/user_model.dart';
import 'package:authentication_app/modules/user/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

// Controller responsible for handling user registration logic
class RegistrationUserController extends GetxController {
  // Instance of UserService for interacting with the API
  final UserService _userService = UserService();

  // Controllers for handling user input fields
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  MaskedTextController userCPF = MaskedTextController(mask: '000.000.000-00');
  TextEditingController password = TextEditingController();

  // Observable UserModel to manage form state
  Rx<UserModel> userForm = UserModel().obs;

  // Observable boolean to track loading state
  RxBool isLoading = false.obs;

  // Observable list to store registered users
  RxList<UserModel> users = <UserModel>[].obs;

  // Clears all input fields
  void cleanFields() {
    userName.clear();
    userEmail.clear();
    userCPF.clear();
    password.clear();
  }

  // Fills input fields with user data
  void fillFields(UserModel user) {
    cleanFields();
    userName.text = user.userName;
    userEmail.text = user.userEmail;
    userCPF.text = user.userCpf;
    password.text = user.password;
  }

  // Submits the user registration form
  Future<void> submit() async {
    try {
      isLoading.value = true;

      // Creates a new UserModel instance with input values
      UserModel newUser = UserModel(
        userName: userName.text,
        userEmail: userEmail.text,
        userCpf: userCPF.text,
        password: password.text,
      );

      // Sends user data to the API and adds the created user to the list
      final UserModel createdUser = await _userService.createUser(newUser);
      users.add(createdUser);

      // Shows success message and navigates to the login screen
      Get.snackbar("Sucesso", "Usuário criado com sucesso");
      Get.offNamed('/login');
    } catch (error) {
      // Shows error message in case of failure
      Get.snackbar("Erro", "Erro ao criar o usuário");
    } finally {
      // Resets loading state
      isLoading.value = false;
    }
  }
}
