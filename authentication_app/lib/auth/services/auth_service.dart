import 'package:authentication_app/auth/models/auth_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert'; // Import to decode JSON
import 'package:flutter/services.dart'; // Import to load assets files

class AuthService {
  
  // Instance of Dio for handling HTTP requests
  final Dio _dio = Dio();

  // Variable to store the backend base URL
  late String baseUrl;

  // Endpoint for login authentication
  final String loginEndpoint = 'auth/token/';

  // Constructor that calls the method to load env.json
  AuthService() {
    _loadEnv();
  }

  // Method to load baseUrl from env.json
  Future<void> _loadEnv() async {
    try {
      // Load env.json from assets
      final String envString = await rootBundle.loadString('assets/env.json');

      // Decode JSON data
      final Map<String, dynamic> envData = json.decode(envString);

      // Assign BASEURL value to baseUrl variable
      baseUrl = envData['BASEURL'];

      // Print the loaded URL for debugging
      print("Base URL carregada: $baseUrl");
    } catch (e) {
      // Print error message if loading fails
      print("Erro ao carregar o env.json: $e");
    }
  }

  // Method to handle user login request
  Future<Map<String, dynamic>> login(AuthModel authModel) async {
    try {
      // Ensure baseUrl is loaded before making the request
      await _loadEnv();

      // Send HTTP POST request with user credentials
      final response = await _dio.post(
        '$baseUrl$loginEndpoint',
        data: authModel.toJson(),
      );

      // Check if the response status is 200 (Success)
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Return error if authentication fails
        return Future.error("Erro ao autenticar");
      }
    } on DioException catch (error) {
      // Handle Dio-specific exceptions and return error message
      return Future.error(error.response?.data ?? "Erro desconhecido");
    }
  }
}
