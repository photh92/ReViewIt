import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewDetailScreen extends ConsumerWidget {
  final String reviewId;

  const ReviewDetailScreen({super.key, required this.reviewId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ViewModel을 watch하여 상세 데이터를 표시할 위치

    return Scaffold(
      appBar: AppBar(
        title: Text('리뷰 상세 ($reviewId)'),
      ),
      body: Center(
        child: Text('리뷰 ID: $reviewId 의 상세 정보를 로드할 예정'),
      ),
    );
  }
}