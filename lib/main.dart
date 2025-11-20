import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/routes/app_router.dart';
import 'features/feed/presentation/screens/feed_screen.dart';

void main() {
  runApp(
    // Riverpod을 사용하려면 ProviderScope로 감싸야 함
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router( // MaterialApp.router 사용
      title: 'ReViewIt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppRouter.router, // AppRouter 연결
    );
  }
}