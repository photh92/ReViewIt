// lib/features/feed/presentation/viewmodels/review_detail_view_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reviewit/features/feed/domain/entities/review.dart';
import 'package:reviewit/features/feed/domain/usecases/get_review_detail_usecase.dart';

import '../../domain/usecases/update_review.dart';
import 'feed_list_view_model.dart';

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

  // 좋아요 토글 및 낙관적 업데이트 로직
  Future<void> toggleLike() async {
    final currentReview = state.value;
    if (currentReview == null) return;

    final newIsLiked = !currentReview.isLiked;
    final newLikeCount = newIsLiked
        ? currentReview.likeCount + 1
        : currentReview.likeCount - 1;

    // 낙관적 업데이트 (UI 즉시 반영)
    final optimisticReview = currentReview.copyWith(
      isLiked: newIsLiked,
      likeCount: newLikeCount,
    );
    state = AsyncValue.data(optimisticReview); // UI는 즉시 업데이트됨

    try {
      // 서버에 업데이트 요청 (Use Case 호출)
      final updateReview = ref.read(updateReviewUseCaseProvider);
      await updateReview.execute(reviewId: currentReview.id, isLiked: newIsLiked);

      // FeedsViewModel Provider를 무효화(Invalidate)
      ref.invalidate(feedListViewModelProvider);

      // 서버 성공 응답 후 (상태 유지)
      print('Like status confirmed by server.');

    } catch (e, stack) {
      // 서버 통신 실패 시 (롤백)
      state = AsyncValue.data(currentReview); // 이전 상태로 롤백
      // 에러 메시지 표시 로직 추가 필요
      print('서버 통신 실패! 좋아요 상태 롤백됨: $e');
    }
  }
}
