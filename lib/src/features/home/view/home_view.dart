import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../constants/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
          child: Text(
        "Home Screen!",
        style: boldTextStyle(size: 22),
      )),
    );
  }
}
