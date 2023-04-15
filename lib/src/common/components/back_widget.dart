import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BackWidget extends StatelessWidget {
  final Function()? onPressed;
  final Color? iconColor;

  const BackWidget({super.key, this.onPressed, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () => finish(context),
      child: Icon(
        Icons.arrow_back_ios,
        color: iconColor ?? Colors.white,
      ),
    );
  }
}
