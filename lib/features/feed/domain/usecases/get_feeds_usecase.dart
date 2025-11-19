import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reviewit/features/feed/domain/entities/review.dart';

import '../../data/repositories/review_repository_impl.dart';
import '../repositories/review_repository.dart' hide reviewRepositoryProvider;

class GetFeedsUseCase {
  final ReviewRepository _repository;

  GetFeedsUseCase(this._repository);

  // UseCase의 실행 함수
  Future<List<Review>> execute({int page = 1, int limit = 10}) async {
    // 여기서 비즈니스 로직을 추가 (예: 데이터 필터링, 캐싱 결정)
    return await _repository.fetchFeeds(page: page, limit: limit);
  }
}

// Riverpod Provider로 UseCase 인스턴스를 제공
final getFeedsUseCaseProvider = Provider<GetFeedsUseCase>((ref) {
  // repository 인스턴스를 먼저 확보
  final repository = ref.watch(reviewRepositoryProvider);
  return GetFeedsUseCase(repository);
});