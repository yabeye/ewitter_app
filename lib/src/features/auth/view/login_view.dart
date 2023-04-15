import 'package:ewitter_app/src/constants/constants.dart';
import 'package:ewitter_app/src/constants/ui_constants.dart';
import 'package:ewitter_app/src/theme/theme.dart';
import 'package:ewitter_app/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _usernameOrEmailController;
  late final TextEditingController _passwordController;

  bool _isRemember = true;

  @override
  void initState() {
    super.initState();

    _usernameOrEmailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameOrEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildRememberWidget() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: RoundedCheckBox(
            borderColor: context.primaryColor,
            checkedColor: context.primaryColor,
            isChecked: _isRemember,
            text: "Remember me",
            textStyle: secondaryTextStyle(),
            size: 20,
            onTap: (value) async {
              _isRemember = !_isRemember;
              setState(() {});
            },
          ),
        ),
        24.height,
        AppButton(
          text: "Log In",
          color: KPallet.primaryColor,
          textStyle: boldTextStyle(color: white),
          width: context.width() - context.navigationBarHeight,
          onTap: () {},
        ),
        60.height,
        TextButton(
          onPressed: () {},
          child: Text(
            "Forgot Password?",
            style: boldTextStyle(
              color: KPallet.primaryColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?", style: secondaryTextStyle()),
            TextButton(
              onPressed: () {
                hideKeyboard(context);
              },
              child: Text(
                "SignUp",
                style: boldTextStyle(
                  color: KPallet.primaryColor,
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              20.height,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Log In",
                  style: boldTextStyle(
                    size: heading2Size,
                    color: KPallet.whiteColor,
                  ),
                ),
              ),
              40.height,
              AppTextField(
                textFieldType: TextFieldType.EMAIL,
                controller: _usernameOrEmailController,
                errorThisFieldRequired: "email is required",
                decoration: inputDecoration(context, labelText: "Email"),
                suffix: KAssets.messageIcon.iconImage(size: 10).paddingAll(14),
                autoFillHints: const [AutofillHints.email],
                onFieldSubmitted: (s) {},
              ),
              20.height,
              AppTextField(
                textFieldType: TextFieldType.PASSWORD,
                controller: _passwordController,
                suffixPasswordVisibleWidget:
                    KAssets.showIcon.iconImage(size: 10).paddingAll(14),
                suffixPasswordInvisibleWidget:
                    KAssets.hideIcon.iconImage(size: 10).paddingAll(14),
                decoration: inputDecoration(context, labelText: "Password"),
                autoFillHints: const [AutofillHints.password],
                onFieldSubmitted: (s) {},
              ),
              20.height,
              _buildRememberWidget(),
            ],
          ),
        ).paddingAll(32),
      ),
    );
  }
}
