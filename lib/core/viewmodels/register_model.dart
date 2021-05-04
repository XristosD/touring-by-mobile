import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/models/user.dart';
import 'package:touring_by/core/services/api_services/auth_api_service.dart';
import 'package:touring_by/core/services/shared_preferences_service.dart';
import 'package:touring_by/core/services/user_service.dart';
import 'package:touring_by/locator.dart';

enum ViewState { Idle, Busy }

class RegisterModel extends ChangeNotifier{
  ViewState _state = ViewState.Idle;
  String errorMessage;

  ViewState get state => _state;

  void setState(ViewState viewState){
    _state = viewState;
    notifyListeners();
  }

  Future<bool> register(String name, String email, String password) async {
    setState(ViewState.Busy);

    ApiResponse response = await locator<AuthApiService>().registerUser(name, email, password);

    if( response.success ){
      await locator<UserService>().createUser((response.body)["user"]);
    }
    else {
      if(response.body is Exception){
        errorMessage = "Registration failled. Check network connection.";
      }
      else{
        errorMessage = "";
        var errors = response.body["errors"];
        // print(response.body["errors"]['email']);
        (response.body["errors"] as Map<String, dynamic>).forEach((key, value) {
          (value as List<dynamic>).forEach((element) {
            errorMessage = errorMessage + element +'\n';
          });
        });
      }
    }

    setState(ViewState.Idle);
    return response.success;

    // print(response.body);
    return true;
  }
}