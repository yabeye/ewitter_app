import 'package:flutter/material.dart';
import 'package:ewitter_app/src/features/splash/splash_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/constants/constants.dart';
import 'src/theme/theme.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const ProviderScope(child: MyApp()));
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
