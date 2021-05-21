import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/models/image_picker_response.dart';
import 'package:touring_by/core/models/touring_by.dart';
import 'package:touring_by/core/models/touring_by_initial_state.dart';
import 'package:touring_by/core/models/touring_by_point.dart';
import 'package:touring_by/core/services/api_services/choose_tour_api_service.dart';
import 'package:touring_by/core/services/api_services/touring_by_api_service.dart';
import 'package:touring_by/core/services/image_picker_service.dart';
import 'package:touring_by/core/services/pick_image_with_dialog_service.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/shared/app_colors.dart';

enum ViewState {Idle, Completing, Skipping, GettingNext}

class TouringByModel extends ChangeNotifier {
  ViewState _state;
  TouringBy touringBy;
  TouringByPoint currentTouringByPoint;
  bool _showDescription = false;
  Completer<GoogleMapController> _controller ;
  ScaffoldState scaffold;

  ViewState get state => _state;
  double get showDescrptionOpacity => _showDescription ? 1.0 : 0.0;
  bool get ignorePointerDescription => !_showDescription;
  bool get lastPoint => !currentTouringByPoint.hasNext;
  Completer<GoogleMapController> get controller => _controller ?? (_controller = Completer());


  Future initiallizeTouringBy({TouringByInitialState touringByInitialState, ScaffoldState scaffold}) async {
    if(this.touringBy != null){
      return true;
    }
    ApiResponse response;

    // TODO remove on deploy
    await new Future.delayed(const Duration(seconds: 2));
    if(touringByInitialState.newTouringBy){
      response = await locator<TouringByApiService>().newTouringByForTour(touringByInitialState.tourId);
    }
    if(response.success){
      this.touringBy = TouringBy.fromJson(response.body);
      print(this.touringBy.toJson().toString());
    }
    this.scaffold = scaffold;
    return true;
  }

  Future<bool> finishTouringBy() async {
    ApiResponse response;

    setState(ViewState.Completing);

    // TODO remove on deploy
    await new Future.delayed(const Duration(seconds: 2));
    response = await locator<TouringByApiService>().finishTouringBy(this.touringBy.id);
    setState(ViewState.Idle);
    if(response.success){
      print(response.body.toString());
      return true;
    }
    else{
      print(this.touringBy.id.toString());
      print(response.body.toString());
      return false;
    }
  }

  Future getCurrentTouringByPoint() async {
    if(this.currentTouringByPoint != null){
      return true;
    }
    ApiResponse response;

    // TODO remove on deploy
    await new Future.delayed(const Duration(seconds: 2));
    response = await locator<TouringByApiService>().curentTouringByPointForTouringBy(this.touringBy.id);
    if(response.success) {
      this.currentTouringByPoint = TouringByPoint.fromJson(response.body);
      setState(ViewState.Idle);
      animateCamera(this.currentTouringByPoint.point.latitude, this.currentTouringByPoint.point.longitude);

      return true;
    }
  }

  Future nextTouringByPoint(bool skipCurrent) async {
    ApiResponse response;

    skipCurrent ? setState(ViewState.Skipping) : setState(ViewState.GettingNext);

    // TODO remove on deploy
    await new Future.delayed(const Duration(seconds: 2));
    response = await locator<TouringByApiService>().NextTouringByPointForTouringBy(this.touringBy.id, skipCurrent);
    if(response.success) {
      this.currentTouringByPoint = TouringByPoint.fromJson(response.body);
      print(this.currentTouringByPoint.toJson().toString());
      setState(ViewState.Idle);
      await animateCamera(this.currentTouringByPoint.point.latitude, this.currentTouringByPoint.point.longitude);
      if(!currentTouringByPoint.hasNext){
        this.showSnackBar("This is the last point of the tour.");
      }
    }
    else{
      if(response.body == "No more points"){
        this.showSnackBar("This is the last point of the tour. Tap FINISH when done to return.");
        setState(ViewState.Idle);
      }
    }
  }

  Future<void> toggleLike() async {
    ApiResponse response;

    if(this.currentTouringByPoint.like){
      response = await locator<TouringByApiService>()
          .likeUnlikeTouringByPoint(touringByPointId: this.currentTouringByPoint.id, like: false);
    }
    else{
      response = await locator<TouringByApiService>()
          .likeUnlikeTouringByPoint(touringByPointId: this.currentTouringByPoint.id, like: true);
    }
    if(response.success){
      this.currentTouringByPoint.like = !this.currentTouringByPoint.like;
    }
    notifyListeners();
  }

  Future<void> setImage(BuildContext context) async {
    ImagePickerResponse response = await locator<ImagePickerService>().pickImage();
    if(response.hasImage){
      ApiResponse apiResponse = await locator<TouringByApiService>()
          .uploadImageForTouringByPoint(this.currentTouringByPoint.id, response.image);
      if(apiResponse.success){
        print(touringBy.id.toString());
        print(currentTouringByPoint.id.toString());
        currentTouringByPoint.hasImage = true;
        notifyListeners();
      }
      else{
        print('error');
      }
    }
  }

  void toggleShowDescription(){
    _showDescription = !_showDescription;
    notifyListeners();
  }

  Future<void> animateCamera(double latitude, double longitude) async {
    while(!this._controller.isCompleted){
      Future.delayed(Duration(milliseconds: 500));
    }
    final GoogleMapController controller = await this._controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 18));
  }

  void showSnackBar(String message){
    scaffold.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 4),
          action: SnackBarAction(
            label: "ok",
            textColor: primaryColor,
            onPressed: (){},
          ),
        )
    );
  }

  void setState(ViewState viewState){
    _state = viewState;
    notifyListeners();
  }

}