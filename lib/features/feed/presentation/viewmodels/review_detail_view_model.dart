// lib/features/feed/presentation/viewmodels/review_detail_view_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reviewit/features/feed/domain/entities/review.dart';
import 'package:reviewit/features/feed/domain/usecases/get_review_detail_usecase.dart';

// Provider 정의
final reviewDetailViewModelProvider =
NotifierProvider.family<ReviewDetailViewModel, AsyncValue<Review>, String>(
  ReviewDetailViewModel.new,
);

// Notifier 구현
class ReviewDetailViewModel extends Notifier<AsyncValue<Review>> {
  // 생성자로 family 인자 받기
  ReviewDetailViewModel(this.reviewId);

  final String reviewId;

  @override
  AsyncValue<Review> build() {
    // build 시점에 비동기 로드 시작
    _fetchReview();
    return const AsyncValue.loading();
  }

  Future<void> _fetchReview() async {
    // 로딩 상태
    state = const AsyncValue.loading();

    try {
      final getReviewDetail = ref.read(getReviewDetailUseCaseProvider);
      final review = await getReviewDetail.execute(reviewId: reviewId);

      // notifier가 아직 mounted 되어있을 때만 상태 업데이트
      if (!ref.mounted) return;

      // print('review: ${review.toString()}');

      state = AsyncValue.data(review);
    } catch (e, stack) {
      if (!ref.mounted) return;
      state = AsyncValue.error(e, stack);
      // 디버그 로그
      print('상세 리뷰 로드 중 오류 발생: $e');
    }
  }
}
