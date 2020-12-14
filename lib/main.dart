import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tours_app/bloc/google-sign-in/google_sign_in_bloc.dart';
import 'package:tours_app/bloc/user/user_bloc.dart';
import 'package:tours_app/config/palette.dart';
import 'package:tours_app/screens/home_screen.dart';
import 'package:tours_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GoogleSignInBloc()..add(AppStartedEvent()),
        ),
        BlocProvider(create: (context) => UserBloc()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Palette.mainColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocBuilder<GoogleSignInBloc, GoogleSignInState>(
          builder: (context, state) {
            if (state is GoogleAuthState) {
              return HomeScreen();
            } else {
              return SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
