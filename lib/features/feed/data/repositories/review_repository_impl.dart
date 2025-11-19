import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reviewit/core/api/api_service.dart';
import 'package:reviewit/features/feed/domain/entities/review.dart';
import 'package:reviewit/features/feed/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ApiService _apiService;

  ReviewRepositoryImpl(this._apiService);

  @override
  Future<List<Review>> fetchFeeds({required int page, required int limit}) async {
    try {
      // MockAPI 엔드포인트에 GET 요청
      final response = await _apiService.dio.get(
        '/reviews',
        queryParameters: {
          '_page': page,
          '_limit': limit,
          // 정렬 옵션 추가
          '_sort': 'createdAt',
          '_order': 'desc',
        },
      );

      // JSON 응답을 Review 모델 리스트로 변환
      final List<dynamic> data = response.data;
      return data.map((json) => Review.fromJson(json)).toList();
    } on DioException catch (e) {
      // Dio 에러 처리 (네트워크 문제, 404 등)
      throw Exception('Failed to fetch feeds: ${e.message}');
    } catch (e) {
      // 기타 예외 처리
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Review> getReviewDetail(String reviewId) {
    throw UnimplementedError();
  }
}

// Provider를 실제 구현체로 연결합니다.
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ReviewRepositoryImpl(apiService);
});