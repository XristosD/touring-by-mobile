

import 'package:flutter/cupertino.dart';

class ValidationService {
  final RegExp _emailRegExp = new RegExp("^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");

  String email({String message, bool shouldTrim, String value}) {
    value = (shouldTrim ?? false)? value.trim() : value;
    if (!_emailRegExp.hasMatch(value)){
      return message ?? "Please enter a valid email";
    }
    return null;
  }

  String notEmpty({String value, String fieldName, bool shouldTrim, String message}){
    value = (shouldTrim ?? false) ? value.trim() : value;
    if (value == null || value.isEmpty){
      return message ?? "$fieldName is requiredd";
    }
    return null;
  }

  String equals({
    String value,
    String message,
    bool shouldTrim,
    String fieldName,
    TextEditingController equalsController,
    String equalsFieldName
  }){
    value = (shouldTrim ?? false) ? value.trim() : value;

    if(value == equalsController.text){
      return null;
    }
    else{
      return message ?? "$fieldName and $equalsFieldName should match";
    }
  }

  // Old Implementation

  Function emailValidator() {
    return (value) {

      var email = value.trim();
      if (_isEmptyField(email)){
        return "Email is required.";
      }
      if (!_emailRegExp.hasMatch(email)){
        return "Please enter a valid email";
      }
      return null;
    };
  }

  Function emptyFieldValidator({bool shouldTrim, String fieldName}) {
    return (value) {
      if (shouldTrim){
        value = value.trim();
      }
      if (_isEmptyField(value)){
        return "$fieldName is required.";
      }
      return null;
    };
  }

  bool _isEmptyField(value){
    if (value == null || value.isEmpty){
      return true;
    }
    return false;
  }




}