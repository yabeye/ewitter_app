import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../common/components/components.dart';
import '../../../constants/constants.dart';
import '../../../constants/ui_constants.dart';
import '../../../theme/theme.dart';
import '../controllers/auth_controller.dart';
import 'signup_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;

  bool _isRemember = true;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _onLogIn() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref.read(authControllerProvider.notifier).logIn(
          context,
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appBar(
        titleWidget: LogoLoader(isLoading: isLoading),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              60.height,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Log In",
                  style: boldTextStyle(
                    size: heading2Size,
                    color: KPalette.whiteColor,
                  ),
                ),
              ),
              40.height,
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
                textFieldType: TextFieldType.PASSWORD,
                errorFieldRequired: "password is required",
                labelText: "Password",
                autoFillHints: const [AutofillHints.password],
                onFieldSubmitted: (s) {},
                isPassword: true,
              ),
              20.height,
              _buildRememberWidget(),
            ],
          ),
        ).paddingSymmetric(horizontal: 32),
      ),
    );
  }

  Widget _buildRememberWidget() {
    final isLoading = ref.watch(authControllerProvider);

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
          color: KPalette.primaryColor,
          textStyle: boldTextStyle(color: white),
          width: context.width() - context.navigationBarHeight,
          onTap: isLoading ? null : _onLogIn,
        ),
        60.height,
        TextButton(
          onPressed: () {},
          child: Text(
            "Forgot Password?",
            style: boldTextStyle(
              color: KPalette.primaryColor,
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
                const SignUpView().launch(context, isNewTask: false);
              },
              child: Text(
                "SignUp",
                style: boldTextStyle(
                  color: KPalette.primaryColor,
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
