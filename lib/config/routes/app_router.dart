import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:reviewit/features/feed/presentation/screens/feed_screen.dart';
import 'package:reviewit/features/feed/presentation/screens/review_detail_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const FeedScreen(),
      ),
      GoRoute(
        path: '/review/:reviewId', // 리뷰 ID를 파라미터로 받음
        name: 'reviewDetail',
        builder: (context, state) {
          // URL 경로에서 reviewId를 추출하여 상세 화면에 전달
          final reviewId = state.pathParameters['reviewId']!;
          return ReviewDetailScreen(reviewId: reviewId);
        },
      ),
    ],
  );
}