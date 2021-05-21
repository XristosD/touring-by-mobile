import 'dart:io';

class ImagePickerResponse {
  File _image;

  void setImage(File image){
    this._image = image;
  }
  void unSetImage(){
    this._image = null;
  }
  bool get hasImage => this._image != null;
  File get image => this._image;
}