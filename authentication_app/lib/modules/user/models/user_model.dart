import 'dart:convert';

// Model class representing a User entity
class UserModel {
  // Private fields for user properties
  int? _userId;
  String? _userName;
  String? _userCpf;
  String? _userEmail;
  String? _password;

  // Constructor for initializing user properties
  UserModel({
    userId,
    userName,
    userCpf,
    userEmail,
    password,
  }) {
    _userId = userId;
    _userName = userName;
    _userCpf = userCpf;
    _userEmail = userEmail;
    _password = password;
  }

  // Getter and setter for user ID
  int get userId => _userId ?? 0;
  set userId(int? value) {
    _userId = value ?? 0;
  }

  // Getter and setter for user name
  String get userName => _userName ?? '';
  set userName(String? value) {
    _userName = value ?? '';
  }

  // Getter and setter for user CPF
  String get userCpf => _userCpf ?? '';
  set userCpf(String? value) {
    _userCpf = value ?? '';
  }

  // Getter and setter for user email
  String get userEmail => _userEmail ?? '';
  set userEmail(String? value) {
    _userEmail = value ?? '';
  }

  // Getter and setter for user password
  String get password => _password ?? '';
  set password(String? value) {
    _password = value ?? '';
  }

  // Factory constructor to create a UserModel instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      userName: json['user_name'],
      userCpf: json['user_cpf'],
      userEmail: json['user_email'],
      password: json['password'],
    );
  }

  // Method to convert UserModel instance to JSON string
  toJson() {
    return jsonEncode({
      'user_id': userId,
      'user_name': userName,
      'user_cpf': userCpf,
      'user_email': userEmail,
      'password': password,
    });
  }
}
