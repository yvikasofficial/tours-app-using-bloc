import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:tours_app/bloc/user/user_bloc.dart';
import 'package:tours_app/config/constants.dart';
import 'package:tours_app/model/tour.dart';
import 'package:tours_app/providers/image_provider.dart' as img;
import 'package:tours_app/widgets/button.dart';
import 'package:tours_app/widgets/loading.dart';
import 'package:tours_app/widgets/round_image.dart';
import 'package:tours_app/widgets/text_field.dart';
import 'package:uuid/uuid.dart';

class AddTourScreen extends StatefulWidget {
  @override
  _AddTourScreenState createState() => _AddTourScreenState();
}

class _AddTourScreenState extends State<AddTourScreen> {
  final _formKey = GlobalKey<FormState>();
  final _desController = TextEditingController();
  final _locationController = TextEditingController();
  File _file;
  final apiKey = "9cba07fb348441adb0135bc2650424f6";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return LoadingWidget(
        isLoading: state.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Add New Tour"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              SizedBox(height: 50),
              RoundImage(
                  onRemove: () {
                    setState(() {
                      _file = null;
                    });
                  },
                  onSelect: () async {
                    final file =
                        await img.ImageProvider.selectImageFromGallery();
                    setState(() {
                      _file = file;
                    });
                  },
                  file: _file),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextField(
                      icon: Icons.location_on,
                      hintText: "Location",
                      showLocate: true,
                      textEditingController: _locationController,
                      onLocate: () => _handleShowPos(),
                    ),
                    MyTextField(
                      icon: Icons.info,
                      hintText: "Description",
                      maxLength: 1000,
                      textEditingController: _desController,
                    ),
                  ],
                ),
              ),
              Button(
                lable: "Upload Tour",
                onPressed: _handleSubmitImage,
              ),
            ],
          ),
        ),
      );
    });
  }

  _handleSubmitImage() async {
    if (_file != null) {
      if (_formKey.currentState.validate()) {
        try {
          BlocProvider.of<UserBloc>(context).add(PushLoadingEvent());
          final uid = Uuid().v4();

          BlocProvider.of<UserBloc>(context).add(
            UploadTourData(
              tour: Tour(
                  imageUrl: await img.ImageProvider.uploadImageToFirestore(
                      _file, uid),
                  location: _locationController.text,
                  uid: uid,
                  des: _desController.text),
            ),
          );
        } catch (e) {
          kShowElertBox(context, "Unexpected Error Occured!", title: "");
        }
      }
    } else {
      kShowElertBox(context, "Please Select an Image", title: "");
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  _handleShowPos() async {
    final Position pos = await _determinePosition();
    final res = await http.get(
        'https://api.opencagedata.com/geocode/v1/json?q=${pos.latitude}+${pos.longitude}&key=${apiKey}');
    var data = json.decode(res.body)['results'][0]["components"];
    _locationController.text = data["town"] + "," + data["state_district"];
  }
}
