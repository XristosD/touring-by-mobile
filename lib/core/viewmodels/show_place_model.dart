

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/models/tour.dart';
import 'package:touring_by/core/services/api_services/get_model_api_service.dart';
import 'package:touring_by/locator.dart';

enum ViewState { Idle, Busy}

class ShowPlaceModel extends ChangeNotifier {

  ViewState _state;
  bool _initialLoad;
  List<Tour> itemList;

  ShowPlaceModel(){
    _state = ViewState.Busy;
    _initialLoad = true;
  }

  ViewState get state => _state;
  int get itemCount => itemList != null ? itemList.length : null;
  bool get initialLoad => _initialLoad;

  Future load(int placeId) async {
    setState(ViewState.Busy);
    if(_initialLoad){
      _initialLoad = false;
    }
    // TODO to be removed on deploy
    await new Future.delayed(const Duration(seconds: 2));
    ApiResponse response = await locator<GetModelApiService>().getToursForPlace(placeId);
    if(response.success){
      itemList = List<Tour>.from(response.body["tours"].map((item) => Tour.fromJson(item)));
    }
    // TODO actions for failed response
    setState(ViewState.Idle);
  }

  void setState(ViewState viewState){
    _state = viewState;
    notifyListeners();
  }

}