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
          'page': page,
          'limit': limit,
          'sortBy': 'createdAt',
          'order': 'desc',
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
  Future<Review> getReviewDetail(String reviewId) async {
    try {
      // API: GET /reviews/{reviewId}
      final response = await _apiService.dio.get('/reviews/$reviewId');

      // 응답 데이터는 단일 JSON 객체여야 함
      final reviewJson = response.data;

      // JSON을 Review 모델로 변환
      return Review.fromJson(reviewJson);
    } on DioException catch (e) {
      print('Dio Error in getReviewDetail: ${e.message}');
      throw Exception('Failed to fetch review detail: ${e.message}');
    } catch (e) {
      print('General Error in getReviewDetail: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> updateReviewLikeStatus(String reviewId, bool isLiked) async {
    // MockAPI는 PATCH/PUT을 지원하지만, 여기서는 상태 업데이트를 시뮬레이션

    // 💡 실제로는 여기서 Dio를 사용하여 PATCH/PUT 요청을 보냄
    /* await _apiService.dio.patch(
    '/reviews/$reviewId',
    data: {'isLiked': isLiked},
  );
  */

    // 서버 응답 지연을 시뮬레이션하여 Optimistic Update를 테스트
    await Future.delayed(const Duration(milliseconds: 500));

    print('Review ID $reviewId Like status updated to $isLiked on server (Simulated)');
  }
}

// Provider를 실제 구현체로 연결합니다.
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ReviewRepositoryImpl(apiService);
});