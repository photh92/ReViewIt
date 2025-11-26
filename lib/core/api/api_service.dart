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
  try {
    // ⭐️ ApiService 생성 시 에러가 없는지 확인 ⭐️
    // 예: Dio 인스턴스가 올바른 baseUrl을 사용하는지 확인
    return ApiService();
  } catch (e) {
    // 만약 ApiService 생성 시 예외가 발생하면, 해당 예외가 RepositoryProvider로 전파됩니다.
    print('ApiService 생성 오류: $e');
    rethrow;
  }
});