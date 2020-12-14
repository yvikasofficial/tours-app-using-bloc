import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tours_app/bloc/google-sign-in/google_sign_in_bloc.dart';
import 'package:tours_app/config/palette.dart';
import 'package:tours_app/widgets/app_logo.dart';
import 'package:tours_app/widgets/loading.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleSignInBloc, GoogleSignInState>(
      builder: (context, state) {
        return LoadingWidget(
          isLoading: state.isLoading,
          child: Scaffold(
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Palette.mainColor,
                      Palette.secondaryColor,
                    ]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppLogo(),
                  ContinueWithGmail(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ContinueWithGmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          BlocProvider.of<GoogleSignInBloc>(context).add(SignInUserEvent()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(EvaIcons.google),
            Text(
              "Continue with Gmail",
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
