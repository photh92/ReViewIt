import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reviewit/features/feed/domain/entities/review.dart';
import 'package:reviewit/features/feed/domain/repositories/review_repository.dart' hide reviewRepositoryProvider;
import 'package:reviewit/features/feed/data/repositories/review_repository_impl.dart';

// UseCase 클래스 정의
class GetReviewDetailUseCase {
  final ReviewRepository _repository;

  GetReviewDetailUseCase(this._repository);

  // Review ID를 받아 단일 Review 객체를 반환
  Future<Review> execute({required String reviewId}) async {
    return await _repository.getReviewDetail(reviewId);
  }
}

// Provider 정의
final getReviewDetailUseCaseProvider = Provider<GetReviewDetailUseCase>((ref) {
  // reviewRepositoryProvider의 구현체(ReviewRepositoryImpl)를 watch
  final repository = ref.watch(reviewRepositoryProvider);
  return GetReviewDetailUseCase(repository);
});