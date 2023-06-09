import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:appwrite/models.dart';
import 'package:ewitter_app/src/features/home/view/home_view.dart';
import 'package:ewitter_app/src/features/auth/view/login_view.dart';

import '../../common/constants/constants.dart';
import '../../common/theme/theme.dart';
import '../auth/controllers/auth_controller.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    afterBuildCreated(() async {
      // TODO: Set some fields to the  localstorage like thememode and language!

      final User? currentUser =
          await ref.watch(authControllerProvider.notifier).currentUserAccount();

      await 3000.milliseconds.delay;
      if (!mounted) return;

      if (currentUser == null) {
        const LoginView().launch(
          context,
          isNewTask: true,
          pageRouteAnimation: PageRouteAnimation.Fade,
        );
      } else {
        // If user is available
        log("Current user is ${currentUser.$id} and  ${currentUser.email} ");

        // TODO: Set some fields to the localstorage like user sync data!

        const HomeView().launch(
          context,
          isNewTask: true,
          pageRouteAnimation: PageRouteAnimation.Fade,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width(),
        height: context.height(),
        color: KPalette.primaryColor,
        child: Center(
          child: SvgPicture.asset(
            KAssets.ewitterLogo,
            width: context.width() * .3,
            height: context.width() * .3,
          ),
        ),
      ),
    );
  }
}
