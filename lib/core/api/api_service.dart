import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// MockAPI URL
const String _kBaseUrl = "https://691bf7ba3aaeed735c8ef39b.mockapi.io/api/v1";

class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio(
    BaseOptions(
        baseUrl: _kBaseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          "Content-Type": "application/json",
        }
    ),
  );

  Dio get dio => _dio;
}

// Riverpod Provider로 ApiService 인스턴스를 제공
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});