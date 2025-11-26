import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reviewit/features/feed/domain/entities/review.dart';

abstract class ReviewRepository {
  // 피드 목록을 페이지네이션 정보와 함께 가져옴
  Future<List<Review>> fetchFeeds({required int page, required int limit});

  // 특정 리뷰의 상세 정보를 가져옴
  Future<Review> getReviewDetail(String reviewId);

  // 수정
  Future<void> updateReviewLikeStatus(String reviewId, bool isLiked);
}
