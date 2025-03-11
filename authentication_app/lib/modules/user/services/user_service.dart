import 'dart:convert';
import 'package:authentication_app/modules/user/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

// Service class responsible for handling user-related API requests
class UserService {
  // Instance of Dio for making HTTP requests
  final Dio _dio = Dio();

  // Base URL for API requests
  late String baseUrl;

  // API module for authentication
  final String module = 'auth/';

  // Constructor that initializes environment variables
  UserService() {
    _loadEnv();
  }

  // Loads environment variables from a JSON file
  Future<void> _loadEnv() async {
    try {
      final String envString = await rootBundle.loadString('assets/env.json');
      final Map<String, dynamic> envData = json.decode(envString);
      baseUrl = envData['BASEURL'];
    } catch (e) {
      Future.error(e);
    }
  }

  // Fetches a list of users from the API
  Future<List<UserModel>> listUsers() async {
    try {
      await _loadEnv();
      final response = await _dio.get('$baseUrl$module');

      // Checks if the response is successful
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        return Future.error("Error fetching users");
      }
    } on DioException catch (error) {
      return Future.error(error.response?.data ?? "Unknown error");
    }
  }

  // Fetches details of a specific user by ID
  Future<UserModel> detailUser(int userId) async {
    try {
      await _loadEnv();
      final response = await _dio.get('$baseUrl$module$userId/');

      // Checks if the response is successful
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        return Future.error('User not found');
      }
    } on DioException catch (error) {
      return Future.error(error.response?.data ?? "Unknown error");
    }
  }

  // Creates a new user in the API
  Future<UserModel> createUser(UserModel user) async {
    try {
      await _loadEnv();

      final response = await _dio.post(
        '$baseUrl${module}create/',
        data: jsonDecode(user.toJson()),
      );

      // Checks if the user was successfully created
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        return Future.error("Error creating user");
      }
    } on DioException catch (error) {
      return Future.error(error.response?.data ?? "Unknown error");
    }
  }

  // Updates an existing user in the API
  Future<UserModel> updateUser(int userId, UserModel user) async {
    try {
      await _loadEnv();

      final response = await _dio.put(
        '$baseUrl${module}update/$userId/',
        data: jsonDecode(user.toJson()),
      );

      // Checks if the update was successful
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        return Future.error("Error updating user");
      }
    } on DioException catch (error) {
      return Future.error(error.response?.data ?? "Unknown error");
    }
  }

  // Deletes a user from the API
  Future<void> deleteUser(int userId) async {
    try {
      await _loadEnv();

      final response = await _dio.delete('$baseUrl${module}deleye/$userId/');

      // Checks if the deletion was successful
      if (response.statusCode == 204) {
        return;
      } else {
        return Future.error("Error deleting user");
      }
    } on DioException catch (error) {
      return Future.error(error.response?.data ?? "Unknown error");
    }
  }
}
