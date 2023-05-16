import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ewitter_app/src/features/splash/splash_view.dart';

import 'src/common/constants/constants.dart';
import 'src/common/theme/theme.dart';

Future<void> main() async {
  await dotenv.load();
  if (!KAppwrite.checkEnvVariables()) {
    if (kDebugMode) {
      print("Please provide all the environment variables!");
    }
    exit(0);
  }

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
      darkTheme: AppTheme.theme,
      home: const SplashView(),
    );
  }
}
