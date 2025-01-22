
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';

import '../../../common/common_textField.dart';
import '../../../common/common_textView.dart';
import '../../../common/my_elevated_button.dart';
import '../../../theme/my_colors.dart';
import '../../../theme/my_icons.dart';
import '../../../util/screen_util.dart';
import '../../bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: MyColors.whiteBG,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Gif(
                image: AssetImage(MyIcons.pdgGif),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: screenUtil.height(04),
            ),
            TextView(
              text: "Login",
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
            SizedBox(height: screenUtil.height(01)),
            TextView(
              text: "Welcome, We save your Document",
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: screenUtil.height(04),
            ),
            CommonTextField(
                controller: emailController,
                hintText: "Username",
                prefixIconPath: MyIcons.userIcon),
            SizedBox(
              height: screenUtil.height(0.5),
            ),
            CommonTextField(
                controller: passwordController,
                hintText: "Password",
                prefixIconPath: MyIcons.passwordIcon),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenUtil.height(04),
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  Navigator.pushReplacementNamed(context, 'baseScreen');
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return CircularProgressIndicator();
                }
                return Column(
                  children: [
                    MyElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            emailController.text, passwordController.text));
                      },
                      text: 'Login',
                      // buttonBGColor: MyColors.gradient85032Toff9068,
                      gradient: MyColors.gradient85032Toff9068,
                      textStyle: TextStyle(
                          color: MyColors.whiteBG,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                    SizedBox(
                      height: screenUtil.height(05),
                    ),
                    Text.rich(
                      TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                              color: MyColors.textFieldHint,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0),
                          children: [
                            TextSpan(
                                text: " Sign Up",
                                style: TextStyle(
                                    color: MyColors.mainColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                        context, 'signUp');
                                  }),
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
