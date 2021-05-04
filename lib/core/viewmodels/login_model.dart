import 'package:flutter/cupertino.dart';
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/services/api_services/auth_api_service.dart';
import 'package:touring_by/core/services/user_service.dart';
import 'package:touring_by/locator.dart';

enum ViewState { Idle, Busy }

class LoginModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  String errorMessage;

  ViewState get state => _state;

  void setState(ViewState viewState){
    _state = viewState;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    setState(ViewState.Busy);

    ApiResponse response = await locator<AuthApiService>().loginUser(email, password);

    if( response.success ){
      await locator<UserService>().createUser(response.body["user"]);
    }
    else {
      if(response.body is Exception){
        errorMessage = "Login failed. Check network connection.";
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
  }
}