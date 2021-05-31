import 'package:flutter/material.dart';
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/services/api_services/auth_api_service.dart';
import 'package:touring_by/core/services/user_service.dart';
import 'package:touring_by/locator.dart';

enum ViewState {Idle, Busy}

class LogoutModel extends ChangeNotifier{
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  Future<bool> logout() async {
    setState(ViewState.Busy);
    ApiResponse response = await locator<AuthApiService>().logout();

    if(response.success){
      await locator<UserService>().logout();
      setState(ViewState.Idle);
      return true;
    }
    else{
      print(response.body.toString());
      setState(ViewState.Idle);
      return false;
    }

  }

  void setState(ViewState viewState){
    _state = viewState;
    notifyListeners();
  }
}