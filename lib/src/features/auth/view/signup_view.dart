import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ewitter_app/src/features/auth/controllers/auth_controller.dart';

import '../../../common/components/components.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late final FocusNode _usernameFocus;
  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;
  late final FocusNode _confirmPasswordFocus;

  bool _doesUserAcceptTC = false;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _usernameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _onSignUp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (!_doesUserAcceptTC) {
      toasty(context, KApp.pleaseAcceptTC);
      return;
    }

    ref.read(authControllerProvider.notifier).signUp(
          context,
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: appBar(
        titleWidget: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("SignUp"),
        ),
        showBack: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              20.height,
              Row(
                children: [
                  LogoLoader(isLoading: isLoading).paddingRight(12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${isLoading ? "Creating" : "Create"} a new account",
                      style: boldTextStyle(
                        size: heading2Size,
                        color: KPallet.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              20.height,
              _buildSignUpForm(context),
              20.height,
              _buildTCWidget(),
              20.height,
              _buildRememberWidget(),
            ],
          ),
        ).paddingSymmetric(horizontal: 32),
      ),
    );
  }

  Column _buildSignUpForm(BuildContext context) {
    return Column(
      children: [
        customTextField(
          context,
          autoFocus: true,
          controller: _usernameController,
          focus: _usernameFocus,
          nextFocusNode: _emailFocus,
          textFieldType: TextFieldType.NAME,
          errorFieldRequired: "Username is required",
          labelText: "Username",
          autoFillHints: const [AutofillHints.username],
          onFieldSubmitted: (s) {},
        ),
        20.height,
        customTextField(
          context,
          controller: _emailController,
          focus: _emailFocus,
          nextFocusNode: _passwordFocus,
          textFieldType: TextFieldType.EMAIL,
          errorFieldRequired: "email is required",
          labelText: "Email",
          autoFillHints: const [AutofillHints.email],
          onFieldSubmitted: (s) {},
        ),
        20.height,
        customTextField(
          context,
          controller: _passwordController,
          focus: _passwordFocus,
          nextFocusNode: _confirmPasswordFocus,
          textFieldType: TextFieldType.PASSWORD,
          errorFieldRequired: "password is required",
          labelText: "Password",
          autoFillHints: const [AutofillHints.password],
          onFieldSubmitted: (s) {},
          isPassword: true,
        ),
        20.height,
        customTextField(
          context,
          controller: _confirmPasswordController,
          textFieldType: TextFieldType.PASSWORD,
          errorFieldRequired: "confirm password is required",
          focus: _confirmPasswordFocus,
          labelText: "Confirm Password",
          autoFillHints: const [AutofillHints.password],
          onFieldSubmitted: (s) {},
          isPassword: true,
          validator: (val) {
            if (val == null) {
              return "";
            }
            if (val.isEmpty) {
              return "Confirm password is required";
            }
            if (_passwordController.text != val) {
              return "Passwords don't match!";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTCWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SelectedItemWidget(isSelected: _doesUserAcceptTC).onTap(() async {
          _doesUserAcceptTC = !_doesUserAcceptTC;
          setState(() {});
        }),
        16.width,
        RichTextWidget(
          list: [
            TextSpan(text: 'Agree on ', style: secondaryTextStyle()),
            TextSpan(
              text: "Terms of Service",
              style: boldTextStyle(color: KPallet.primaryColor, size: 14),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  commonLaunchUrl(
                    KApp.appTermsAndConditionsURL,
                    launchMode: LaunchMode.externalApplication,
                  );
                },
            ),
            TextSpan(text: ' & ', style: secondaryTextStyle()),
            TextSpan(
              text: "Privacy Policy",
              style: boldTextStyle(color: KPallet.primaryColor, size: 14),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  commonLaunchUrl(
                    KApp.privacyPolicyURL,
                    launchMode: LaunchMode.externalApplication,
                  );
                },
            ),
          ],
        ).flexible(flex: 2),
      ],
    ).paddingSymmetric(vertical: 16);
  }

  Widget _buildRememberWidget() {
    final isLoading = ref.watch(authControllerProvider);
    return Column(
      children: [
        AppButton(
          text: "Sign Up",
          color: KPallet.primaryColor,
          textStyle: boldTextStyle(color: white),
          width: context.width() - context.navigationBarHeight,
          onTap: isLoading ? null : _onSignUp,
        ),
        20.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?", style: secondaryTextStyle()),
            TextButton(
              onPressed: () {
                hideKeyboard(context);
                finish(context);
              },
              child: Text(
                "Log In",
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
}
