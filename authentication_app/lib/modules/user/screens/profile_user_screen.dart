import 'package:authentication_app/auth/controllers/auth_controller.dart';
import 'package:authentication_app/modules/user/controllers/list_user_controller.dart';
import 'package:authentication_app/modules/user/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({super.key});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  final ListUserController _userController = Get.find<ListUserController>();
  final AuthController _authController = Get.find<AuthController>();
  late Future<UserModel?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _userController.getUserDetail(_authController.userId.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<UserModel?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("Usuário não encontrado"),
            );
          }
          final user = snapshot.data!;

          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _profileIcon(),
                _nameField(user.userName),
                _emailField(user.userEmail),
                _cpfField(user.userCpf),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _profileIcon() {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.person,
        size: 40,
        color: Colors.white,
      ),
    );
  }

  Widget _infoField(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "$label : $value",
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _nameField(String userName) {
    return _infoField("Nome", userName);
  }

  Widget _emailField(String userEmail) {
    return _infoField("E-mail", userEmail);
  }

  Widget _cpfField(String userCpf) {
    return _infoField("CPF", userCpf);
  }
}
