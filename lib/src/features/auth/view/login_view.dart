import 'package:ewitter_app/src/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: const Center(child: Text("🎬 Lets build Ethiopia's Twitter!")),
    );
  }
}
