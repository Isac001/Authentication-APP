import 'package:authentication_app/modules/login/controllers/login_screen_controller.dart';
import 'package:authentication_app/modules/login/keys/login_screen_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginScreenController _loginScreenController =
      Get.find<LoginScreenController>();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: LoginFormKey.loginFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _titleLogin(),
                  _emailField(),
                  _passwordField(),
                  _rememberLoginRecoverPassword(),
                  _buttonLogin(),
                  _buttonRegister(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _titleLogin() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Bem-vindo(a) de volta!',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// 🔹 Campo de e-mail
  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextFormField(
        controller: _loginScreenController.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "E-mail",
          prefixIcon: const Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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

  /// 🔹 Campo de senha
  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextFormField(
        controller: _loginScreenController.passwordController,
        obscureText: !_passwordVisible, // Alterna visibilidade da senha
        decoration: InputDecoration(
          labelText: "Senha",
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible; // Atualiza o estado
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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

  /// 🔹 Lembrar-me e Esqueci a Senha
  Widget _rememberLoginRecoverPassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => CheckboxListTile(
                title: const Text("Lembrar-me"),
                value: _loginScreenController.stayConnected.value,
                onChanged: (value) {
                  _loginScreenController.stayConnected.value = value!;
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed('/forgotPassword'); // Defina a rota correta aqui
            },
            child: const Text("Esqueci a senha"),
          ),
        ],
      ),
    );
  }

  /// 🔹 Botão de login
  Widget _buttonLogin() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (LoginFormKey.loginFormKey.currentState!.validate()) {
            _loginScreenController.submit();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: const Text("Entrar"),
      ),
    );
  }

  /// 🔹 Botão de cadastro
  Widget _buttonRegister() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: OutlinedButton(
        onPressed: () => Get.toNamed(''),
        child: const Text("Cadastre-se"),
      ),
    );
  }
}
