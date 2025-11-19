import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/feed/presentation/screens/feed_screen.dart';

void main() {
  runApp(
    // Riverpod을 사용하려면 ProviderScope로 감싸야 합니다.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReViewIt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // FeedScreen을 메인 화면으로 설정
      home: const FeedScreen(),
    );
  }
}