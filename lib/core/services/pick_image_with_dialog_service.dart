import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:touring_by/core/models/image_picker_response.dart';

class PickImageWithDialogService {
  // ATENTION!!! This service is not used. This service is not fully implemented.
  // It needs to remove image_picker package and use flutter native camera package
  BuildContext _context;
  ImagePickerResponse _response;


  Future<ImagePickerResponse> startService(BuildContext context) async {
    this._context = context;
    _response = ImagePickerResponse();
    await this._pickAndShowImage();
    
    return this._response;
  }


  Future<void> _pickAndShowImage() async {
    await this._pickImage();
    if(this._response.hasImage){
      await this._showDialog();
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
      imageQuality: 50
    );

    if(pickedFile != null) {
      _response.setImage(File(pickedFile.path));
    }
  }

  Future<void> _showDialog() async {
    return showDialog(
      context: this._context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: null,
          content: Image.file(_response.image),
          actions: [
            TextButton(
                onPressed: () {
                  this._response.unSetImage();
                  Navigator.of(context).pop();
                },
                child: Text("CANCEL")
            ),
            TextButton(
                onPressed: () {
                  this._response.unSetImage();
                  this._pickAndShowImage();
                  Navigator.of(context).pop();
                },
                child: Text("NEW")
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK")
            ),
          ],
        );
      }
    );
  }

}