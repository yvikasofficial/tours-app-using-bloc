import 'package:flutter/material.dart';
import 'package:tours_app/widgets/button.dart';
import 'package:tours_app/widgets/text_field.dart';

class AddTourScreen extends StatefulWidget {
  @override
  _AddTourScreenState createState() => _AddTourScreenState();
}

class _AddTourScreenState extends State<AddTourScreen> {
  final _formKey = GlobalKey<FormState>();
  final _desController = TextEditingController();
  final _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                MyTextField(
                  icon: Icons.location_on,
                  hintText: "Location",
                  textEditingController: _locationController,
                ),
                MyTextField(
                  icon: Icons.info,
                  hintText: "Description",
                  textEditingController: _desController,
                ),
              ],
            ),
          ),
          Button(lable: "Upload Image"),
        ],
      ),
    );
  }

  _handleSubmitImage() async {
    try {} catch (e) {}
  }
}
