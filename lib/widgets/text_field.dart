import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class MyTextField extends StatefulWidget {
  final IconData icon;
  final bool isEmail;
  final bool isPassword;
  final int minLength;
  final int maxLength;
  final String hintText;
  final String value;
  final Function onLocate;
  final bool isNum;
  final TextEditingController textEditingController;
  final bool showLocate;
  MyTextField(
      {@required this.icon,
      @required this.hintText,
      this.textEditingController,
      this.onLocate,
      this.isEmail = false,
      this.value,
      this.maxLength = 30,
      this.isNum = false,
      this.isPassword = false,
      this.showLocate = false,
      this.minLength = 3});
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isVisible = true;

  _handleShowSuffixIcon() {
    if (widget.showLocate) {
      return IconButton(
          onPressed: widget.onLocate,
          icon: Icon(Icons.location_searching_sharp));
    }
    if (widget.isPassword) {
      if (isVisible) {
        return IconButton(
            icon: Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            });
      } else {
        return IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            });
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: widget.isNum ? 10 : 20),
        padding: EdgeInsets.symmetric(horizontal: widget.isNum ? 10 : 30),
        child: TextFormField(
          initialValue: widget.value,
          controller: widget.textEditingController,
          obscureText: widget.isPassword && isVisible,
          cursorColor: Colors.black,
          style: TextStyle(
            fontSize: 18,
          ),
          validator: widget.isEmail
              ? ValidationBuilder().email().maxLength(50).build()
              : ValidationBuilder()
                  .minLength(widget.minLength)
                  .maxLength(widget.maxLength)
                  .build(),
          decoration: InputDecoration(
            border: widget.isNum ? InputBorder.none : UnderlineInputBorder(),
            labelStyle: TextStyle(height: 0),
            hintText: widget.hintText,
            suffixIcon: _handleShowSuffixIcon(),
            prefixIcon: Icon(widget.icon),
          ),
        ),
      ),
    );
  }
}
