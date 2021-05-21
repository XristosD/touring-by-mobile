import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:touring_by/core/models/image_picker_response.dart';

class ImagePickerService {

  Future<ImagePickerResponse> pickImage() async {
    ImagePickerResponse response = ImagePickerResponse();
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 50
    );

    if(pickedFile != null) {
      response.setImage(File(pickedFile.path));
      return response;
    }
    else {
      return response;
    }
  }
}