import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tours_app/bloc/google-sign-in/google_sign_in_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => BlocProvider.of<GoogleSignInBloc>(context)
                  .add(SignOutUserEvent())),
          SizedBox(width: 10),
        ],
        title: Text("NATOURS"),
        centerTitle: true,
      ),
    );
  }
}
