import 'package:e_commerce/theme/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'auth/bloc/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if(state is NavigateToLoginState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, 'login');
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, 'baseScreen');
            });
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: Lottie.asset(MyIcons.splash),
          ),
        ),
        // Scaffold(
        //   body: SizedBox.expand(child: Image.asset('assets/images/splash2.jpg',f),),
        // )


      ),
    );
  }
}
