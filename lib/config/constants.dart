import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    ],
  ).show();
}

kRoute(Widget widget) {
  Get.to(widget, transition: Transition.cupertino);
}
