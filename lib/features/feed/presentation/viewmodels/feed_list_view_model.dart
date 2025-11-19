import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reviewit/features/feed/domain/entities/review.dart';

import '../../domain/usecases/get_feeds_usecase.dart';

// ViewModel 정의: AsyncNotifier를 사용하여 List<Review> 상태를 관리
class FeedListViewModel extends AsyncNotifier<List<Review>> {

  // 초기 로딩만 구현하고, 페이지네이션은 추후 추가
  final int _page = 1;
  final int _limit = 10;

  // build 메서드: 초기 상태를 설정하고 데이터를 로드
  @override
  Future<List<Review>> build() async {
    // UseCase DI: ref.watch를 통해 GetFeedsUseCase 인스턴스를 가져옴
    final getFeeds = ref.watch(getFeedsUseCaseProvider);

    // UseCase 실행: 비즈니스 로직을 실행하여 데이터를 가져옴
    try {
      final reviews = await getFeeds.execute(page: _page, limit: _limit);
      return reviews;
    } catch (e, stack) {
      // 에러 발생 시 상태를 AsyncError로 업데이트
      state = AsyncError(e, stack);
      // 예외를 다시 throw하여 AsyncNotifier가 에러를 잡음
      rethrow;
    }
  }

  // 새로고침 기능을 위한 메서드
  Future<void> refresh() async {
    print("refresh start");
    state = const AsyncLoading();
    // state = AsyncLoading() 대신 ref.invalidateSelf()를 사용하면 build()가 재실행
    ref.invalidateSelf();
  }
}

// Provider 정의: UI가 관찰할 수 있는 최종 Provider를 노출
final feedListViewModelProvider =
AsyncNotifierProvider<FeedListViewModel, List<Review>>(() {
  return FeedListViewModel();
});