import 'dart:math';

import 'package:ewitter_app/src/theme/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:ewitter_app/src/features/auth/view/login_view.dart';
import 'package:ewitter_app/src/constants/constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    afterBuildCreated(() async {
      3000.milliseconds.delay.then((value) {
        //  if logged in ?
        if (true) {
          const LoginView().launch(
            context,
            isNewTask: true,
            pageRouteAnimation: PageRouteAnimation.Fade,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width(),
        height: context.height(),
        color: KPallet.primaryColor,
        child: Center(
          child: SvgPicture.asset(
            KAssets.ewitterLogo,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
