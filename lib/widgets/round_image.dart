import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tours_app/config/palette.dart';

class RoundImage extends StatelessWidget {
  final File file;
  final Function onSelect;
  final Function onRemove;
  RoundImage({this.file, this.onSelect, this.onRemove});
  @override
  Widget build(BuildContext context) {
    return file == null
        ? _NoImage(onSelect: onSelect)
        : _FileImg(
            file: file,
            onRemove: onRemove,
          );
  }
}

class _NoImage extends StatelessWidget {
  final Function onSelect;
  _NoImage({this.onSelect});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: CircleAvatar(
        backgroundColor: Palette.mainColor,
        radius: 50,
        child: CircleAvatar(
          radius: 45,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_a_photo,
            color: Palette.mainColor,
          ),
        ),
      ),
    );
  }
}

class _FileImg extends StatelessWidget {
  final File file;
  final Function onRemove;
  _FileImg({this.file, this.onRemove});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Palette.mainColor,
          backgroundImage: FileImage(file),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onRemove,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.redAccent,
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
