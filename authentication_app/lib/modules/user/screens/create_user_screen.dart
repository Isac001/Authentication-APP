import 'package:authentication_app/modules/user/controllers/registration_user_controller.dart';
import 'package:authentication_app/modules/user/keys/create_user_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// StatefulWidget for the user registration screen
class CreateUserScreen extends StatefulWidget {
  // Constructor for CreateUserScreen
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

// State class for managing the user registration screen's state
class _CreateUserScreenState extends State<CreateUserScreen> {
  // Instance of UserController to handle user registration logic
  final RegistrationUserController _userController =
      Get.find<RegistrationUserController>();

  // Boolean variable to track password visibility
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sets the background color of the screen
      backgroundColor: Colors.white,

      // Container with a blue border around the screen
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 15),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: CreateUserKey.createUserFormKey,
              child: Column(
                children: [
                  _userNameField(),
                  _userEmailField(),
                  _userCpfField(),
                  _passwordField(),
                  _buttonCreate(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget for the username input field
  Widget _userNameField() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: _userController.userName,
        decoration: InputDecoration(
          labelText: "Nome de Usuário",
          prefixIcon: Icon(Icons.person),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha o campo para realizar o cadastro';
          }
          return null;
        },
      ),
    );
  }

  // Widget for the email input field
  Widget _userEmailField() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: _userController.userEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "E-mail de Usuário",
          prefixIcon: Icon(Icons.email),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha o campo para realizar o cadastro';
          }
          return null;
        },
      ),
    );
  }

  // Widget for the CPF input field
  Widget _userCpfField() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: _userController.userCPF,
        decoration: InputDecoration(
          labelText: "CPF do Usuário",
          prefixIcon: Icon(Icons.credit_card),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha o campo para realizar o cadastro';
          }
          return null;
        },
      ),
    );
  }

  // Widget for the password input field with visibility toggle
  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: _userController.password,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          labelText: "Senha de Usuario",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Digite sua senha';
          }
          return null;
        },
      ),
    );
  }

  // Widget for the create user button
  Widget _buttonCreate() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          if (CreateUserKey.createUserFormKey.currentState!.validate()) {
            _userController.submit();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: const Text(
          'Criar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
