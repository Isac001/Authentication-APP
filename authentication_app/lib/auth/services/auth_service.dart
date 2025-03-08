import 'package:authentication_app/auth/models/auth_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert'; // 🔹 Para decodificar JSON
import 'package:flutter/services.dart'; // 🔹 Para carregar arquivos do assets


class AuthService {
  final Dio _dio = Dio();
  late String baseUrl; // 🔹 Variável que armazenará a URL do backend
  final String loginEndpoint = 'auth/token/';

  // 🔹 Construtor que chama o método para carregar o env.json
  AuthService() {
    _loadEnv();
  }

  // 🔹 Método para carregar a baseUrl do env.json
  Future<void> _loadEnv() async {
    try {
      final String envString = await rootBundle.loadString('assets/env.json');
      final Map<String, dynamic> envData = json.decode(envString);
      baseUrl = envData['BASEURL'];
      print("Base URL carregada: $baseUrl"); // ✅ DEBUG
    } catch (e) {
      print("Erro ao carregar o env.json: $e");
    }
  }

  // 🔹 Método de login
  Future<Map<String, dynamic>> login(AuthModel authModel) async {
    try {
      // Aguarda a baseUrl ser carregada antes de continuar
      await _loadEnv();  

      final response = await _dio.post(
        '$baseUrl$loginEndpoint',
        data: authModel.toJson(),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return Future.error("Erro ao autenticar");
      }
    } on DioException catch (error) {
      return Future.error(error.response?.data ?? "Erro desconhecido");
    }
  }
}
