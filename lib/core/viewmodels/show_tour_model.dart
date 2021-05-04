import 'package:flutter/cupertino.dart';
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/models/point.dart';
import 'package:touring_by/core/models/tour.dart';
import 'package:touring_by/core/services/api_services/get_model_api_service.dart';
import 'package:touring_by/core/viewmodels/index_place_model.dart';
import 'package:touring_by/locator.dart';

enum ViewState { Idle, Busy }

class ShowTourModel extends ChangeNotifier {
  ViewState _state = ViewState.Busy;
  int _page;
  bool _hasmore;
  List<Point> itemList;
  bool _initialLoad;

  ShowTourModel(){
    _state = ViewState.Busy;
    _page = 0;
    _hasmore = true;
    itemList = [];
    _initialLoad = true;
  }

  ViewState get state => _state;
  int get nextPage => ++_page;
  bool get hasMore => _hasmore;
  int get itemCount => itemList.length + (state  == ViewState.Busy ? 1 : 0);

  Future loadMore(int tourId) async {
    setState(ViewState.Busy);
    if(_initialLoad){
      _initialLoad = false;
    }
    // TODO to be removed on deploy
    await new Future.delayed(const Duration(seconds: 2));
    ApiResponse response = await locator<GetModelApiService>().getPointsForTourForPage(tourId, nextPage);
    if(response.success){
      _hasmore = response.body["next_page_url"] == null ? false : true;
      itemList.addAll( List<Point>.from(response.body["data"].map((item) => Point.fromJson(item))) );
    }
    // TODO actions for failed response
    setState(ViewState.Idle);
  }

  bool getInitial(){
    if(_initialLoad){
      _initialLoad = false;
      return true;
    }
    return false;
  }

  bool indicatorAdded(int index){
    return index == itemList.length;
  }

  bool timeToLoad(int index){
    return (state == ViewState.Idle && _hasmore && _thressholdReached(index)) || _initialLoad;
  }

  bool _thressholdReached(int index){
    // thresshold is last item
    int thresshold = 0;
    return index == itemList.length-1 - thresshold;
  }

  void setState(ViewState viewState){
    _state = viewState;
    notifyListeners();
  }
}