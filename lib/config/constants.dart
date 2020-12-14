import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tours_app/config/palette.dart';

kShowElertBox(context, String message,
    {AlertType type, String title, bool resendEmail = false}) async {
  return await Alert(
    context: context,
    type: type ?? AlertType.error,
    title: title ?? "Authentication Failed",
    desc: message,
    buttons: [
      DialogButton(
        color: Palette.mainColor,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
      if (resendEmail)
        DialogButton(
          color: Colors.greenAccent,
          child: Text(
            "Resend Email",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () {
            FirebaseAuth.instance.currentUser.sendEmailVerification();
            Navigator.pop(context);
          },
          width: 120,
        ),
    ],
  ).show();
}
