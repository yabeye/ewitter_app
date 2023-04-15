import 'package:ewitter_app/src/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:ewitter_app/src/constants/constants.dart';
import 'package:ewitter_app/src/features/auth/view/login_view.dart';

import 'src/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: KApp.title,
      theme: AppTheme.theme,
      // home: const LoginView(),
      home: const SplashView(),
    );
  }
}
