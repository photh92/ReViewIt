import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/review_repository_impl.dart';
import '../repositories/review_repository.dart';

// 1. UseCase 클래스 정의
class UpdateReviewUseCase {
  final ReviewRepository _repository;

  UpdateReviewUseCase(this._repository);

  // 2. 좋아요 상태를 토글하는 핵심 실행 메서드
  Future<void> execute({required String reviewId, required bool isLiked}) async {
    // 실제 API 호출 로직은 Repository에 위임합니다.
    // MockAPI에서는 실제 PUT/PATCH 요청을 시뮬레이션합니다.
    await _repository.updateReviewLikeStatus(reviewId, isLiked);
  }
}

// 3. Provider 정의
final updateReviewUseCaseProvider = Provider<UpdateReviewUseCase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return UpdateReviewUseCase(repository);
});