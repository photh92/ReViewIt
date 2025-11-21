import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/review.dart';
import '../viewmodels/review_detail_view_model.dart';

class ReviewDetailScreen extends ConsumerWidget {
  final String reviewId;

  const ReviewDetailScreen({super.key, required this.reviewId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ⭐️ reviewDetailViewModelProvider에 reviewId를 인자로 전달하여 watch ⭐️
    final reviewAsyncValue = ref.watch(reviewDetailViewModelProvider(reviewId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('리뷰 상세 정보'),
      ),
      body: reviewAsyncValue.when(
        // 1. 로딩 중
        loading: () => const Center(child: CircularProgressIndicator()),

        // 2. 에러 발생
        error: (err, stack) => Center(child: Text('오류 발생: ${err.toString()}')),

        // 3. 데이터 로드 완료
        data: (review) => _ReviewDetailContent(review: review),
      ),
    );
  }
}

// 상세 정보 표시를 위한 별도 위젯 (옵션)
class _ReviewDetailContent extends StatelessWidget {
  final Review review;

  const _ReviewDetailContent({required this.review});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(review.author.nickname, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(review.mediaTitle, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Text(review.content),
          const SizedBox(height: 24),
          // 좋아요, 평점 등 기타 정보 표시
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('⭐️ 평점: ${review.rating.toStringAsFixed(1)}'),
              Text('❤️ 좋아요: ${review.likeCount}개'),
            ],
          ),
          const SizedBox(height: 8),
          Text('작성일: ${review.createdAt}'), // 실제 앱에서는 날짜 포맷팅 필요
        ],
      ),
    );
  }
}