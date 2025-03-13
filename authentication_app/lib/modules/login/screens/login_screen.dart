import 'package:authentication_app/modules/login/controllers/login_screen_controller.dart';
import 'package:authentication_app/modules/login/keys/login_screen_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  // Constructor for LoginScreen
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Instance of LoginScreenController to manage login logic
  final LoginScreenController _loginScreenController =
      Get.find<LoginScreenController>();

  // Variable to track password visibility
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
            padding: const EdgeInsets.all(20),
            child: Form(
              key: LoginFormKey.loginFormKey,
              child: Column(
                children: [
                  _titleLogin(),
                  _emailField(),
                  _passwordField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _buttonLogin(),
                      ),
                      Expanded(
                        child: _buttonToCreateUser(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget to display the login title
  Widget _titleLogin() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        'Seja Bem Vindo(A)!',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Widget for the email input field
  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: _loginScreenController.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "E-mail",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          prefixIcon: const Icon(Icons.email),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Digite seu e-mail';
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
        controller: _loginScreenController.passwordController,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          labelText: "Senha",
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

  // Widget for the login button
  Widget _buttonLogin() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: ElevatedButton(
        onPressed: () {
          if (LoginFormKey.loginFormKey.currentState!.validate()) {
            _loginScreenController.submit();
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, padding: const EdgeInsets.all(15)),
        child: const Text(
          'Entrar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buttonToCreateUser() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: ElevatedButton(
          onPressed: () {
            Get.toNamed('/create_user');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.all(15),
          ),
          child: const Text(
            'Criar usuario',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
