import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reviewit/features/feed/domain/entities/review.dart';

abstract class ReviewRepository {
  // 피드 목록을 페이지네이션 정보와 함께 가져옴
  Future<List<Review>> fetchFeeds({required int page, required int limit});

  // 특정 리뷰의 상세 정보를 가져옴
  Future<Review> getReviewDetail(String reviewId);

  // 좋아요/댓글/리뷰 작성 등의 인터페이스를 정의
}

// Riverpod Provider로 Repository Interface를 제공할 준비
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  // Data Layer의 실제 구현체로 대체
  throw UnimplementedError('Implementation not yet provided.');
});