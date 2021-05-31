import 'package:flutter/material.dart';
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/services/api_services/show_touring_by_api_service.dart';
import 'package:touring_by/locator.dart';

enum ViewState {Idle, Busy}

class ShareTouringByModel extends ChangeNotifier {
  bool _sharedUserFound;
  String sharedUserName;
  int sharedUserId;
  bool _errorReturned;
  String errorMessage;
  bool _shareResult;
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  bool get errorReturned => _errorReturned ?? false;
  bool get sharedUserFound => _sharedUserFound ?? false;
  bool get shareResult => _shareResult ?? false;

  Future<ApiResponse> findUserByEmail(String email) async {
    ApiResponse response;
    setState(ViewState.Busy);

    this._sharedUserFound = false;
    this._errorReturned = false;
    this._shareResult = false;

    response = await locator<ShowTouringByApiService>().findUserByEmail(email);
    if(response.success){
      this._sharedUserFound = true;
      this.sharedUserId = response.body["id"];
      this.sharedUserName = response.body["name"];
    }
    else{
      this._errorReturned = true;
      if(response.body['errors']['email'][0] == "No user found"){
        this.errorMessage = "Email $email was not found.";
      }
    }
    setState(ViewState.Idle);
  }

  void resetError(){
    this._errorReturned = false;
    this.errorMessage = "";
  }

  Future<bool> shareTouringByToUser(int touringById) async {
    ApiResponse response;
    setState(ViewState.Busy);

    // _shareResult = false;
    response = await locator<ShowTouringByApiService>().shareTouringByToUser(touringById, this.sharedUserId);
    print(response.body.toString());
    if(response.success) {
      _shareResult = true;
      print(response.success);
    }
    print(this.shareResult);
    setState(ViewState.Idle);
    // this._shareResult = false;
    return response.success;
  }

  void setState(ViewState viewState){
    _state = viewState;
    notifyListeners();
  }
}