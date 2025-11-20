import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reviewit/features/feed/domain/entities/review.dart';
import 'package:reviewit/features/feed/presentation/viewmodels/feed_list_view_model.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ViewModel 관찰: feedListViewModelProvider의 상태를 관찰
    final feedAsyncValue = ref.watch(feedListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ReViewIt Feeds'),
        actions: [
          // 새로고침 버튼: 로딩 상태가 아닐 때만 새로고침 가능
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: feedAsyncValue.isLoading
                ? null
                : () => ref.read(feedListViewModelProvider.notifier).refresh(),
          ),
        ],
      ),
      // AsyncValue 상태에 따른 UI 분기 처리
      body: feedAsyncValue.when(
        // 로딩 중
        loading: () => const Center(child: CircularProgressIndicator()),

        // 에러 발생
        error: (err, stack) => Center(
          child: Text('데이터 로드 실패: ${err.toString()}'),
        ),

        // 데이터 성공
        data: (reviews) {
          if (reviews.isEmpty) {
            return const Center(child: Text('아직 작성된 리뷰가 없습니다.'));
          }
          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return ReviewCard(review: review); // 4. 리뷰 카드 위젯 사용
            },
          );
        },
      ),
    );
  }
}

// 리뷰 카드 위젯
class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // GoRouter를 사용하여 상세 화면으로 이동
        context.pushNamed(
          'reviewDetail',
          pathParameters: {'reviewId': review.id},
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.mediaTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                '${review.rating}점 - ${review.mediaType}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(review.content),
              const SizedBox(height: 8),
              Text('작성자: ${review.author.nickname}', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('좋아요: ${review.likeCount}, 댓글: ${review.commentCount}'),
            ],
          ),
        ),
      )
    );
  }
}