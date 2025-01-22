
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gif/gif.dart';

import '../../../common/common_textField.dart';
import '../../../common/common_textView.dart';
import '../../../common/divider.dart';
import '../../../common/my_elevated_button.dart';
import '../../../theme/my_colors.dart';
import '../../../theme/my_icons.dart';
import '../../../util/screen_util.dart';
import '../../bloc/auth_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil(context);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: MyColors.whiteBG,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenUtil.height(05),
              ),
              Center(
                child: Gif(image: AssetImage(MyIcons.pdgGif),height: 80,width: 80,fit: BoxFit.cover,) ,
              ),
              TextView(
                text: "Sign Up",
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
              SizedBox(height: screenUtil.height(01)),
              TextView(
                text: "Set Your Profile",
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: screenUtil.height(02),
              ),
              CommonTextField(
                  controller: nameController,
                  hintText: "Full name",
                  prefixIconPath: MyIcons.userIcon),
              CommonTextField(
                  controller: emailController,
                  hintText: "Email address",
                  prefixIconPath: MyIcons.emailIcon),
              CommonTextField(
                  controller: phoneNumberController,
                  hintText: "Phone number",
                  prefixIconPath: MyIcons.numberIcon),
              CommonTextField(
                  controller: passwordController,
                  hintText: "Password",
                  prefixIconPath: MyIcons.passwordIcon),
              SizedBox(
                height: screenUtil.height(2),
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    Navigator.pop(context);
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if(state is AuthLoading) {
                    return CircularProgressIndicator();
                  }return  MyElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(SignUpEvent(emailController.text, passwordController.text));
                    },
                    text: 'Sign Up',
                    // buttonBGColor: MyColors.gradient85032Toff9068,
                    gradient: MyColors.gradient85032Toff9068,
                    textStyle: TextStyle(
                        color: MyColors.whiteBG,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  );
                },
              ),
              DividerWithText(text: "Or"),
              SizedBox(
                height: screenUtil.height(01),
              ),
              TextView(text: 'Sign Up with',color: MyColors.mainColor,fontWeight: FontWeight.w700,fontSize: 15,),
              SizedBox(
                height: screenUtil.height(0.5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(MyIcons.facebook),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(MyIcons.instagram),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(MyIcons.youtube),
                  )
                ],
              ),
              SizedBox(
                height: screenUtil.height(05),
              ),
              Text.rich(TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                      color: MyColors.textFieldHint,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0),
                  children: [
                    TextSpan(
                        text: " Sign In",
                        style: TextStyle(
                            color: MyColors.mainColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.pushReplacementNamed(context, 'signUp');
                        }
                    ),
                  ]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
