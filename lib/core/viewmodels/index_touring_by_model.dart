import 'package:flutter/material.dart';
import 'package:touring_by/core/enums/index_state.dart';
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/services/api_services/index_touring_by_api_service.dart';
import 'package:touring_by/locator.dart';
import 'package:intl/intl.dart';

enum ViewState {Idle, Busy}

class IndexTouringByModel extends ChangeNotifier {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  IndexState indexState;
  ViewState _viewState;
  bool _initialized;
  int _page;
  bool _hasMore;
  List itemList;

  int get nextPage => ++_page;
  ViewState get viewState => _viewState;

  IndexTouringByModel({@required this.indexState});

  Future<void> initializer() async {
    _viewState = ViewState.Idle;
    itemList = List();
    _initialized = true;
    _page = 1;
    ApiResponse response = await locator<IndexTouringByApiService>().indexTouringBy(indexState, _page);
    if(response.success){
      _hasMore = response.body["next_page_url"] == null ? false : true;
      itemList.addAll(List.from(response.body["data"]));
      // print(itemList);
      // print(itemList.length.toString());
    }
    else{
      print(response.body);
    }
    return;
  }

  Future<void> loadMore() async {
    setState(ViewState.Busy);
    ApiResponse response = await locator<IndexTouringByApiService>().indexTouringBy(indexState, nextPage);
    if(response.success){
      _hasMore = response.body["next_page_url"] == null ? false : true;
      itemList.addAll(List.from(response.body["data"]));
      // print(itemList);
      // print(itemList.length.toString());
    }
    setState(ViewState.Idle);
  }

  bool _thressholdReached(int index){
    // thresshold is last item
    int thresshold = 0;
    return index == itemList.length-1 - thresshold;
  }

  bool timeToLoad(int index){
    return (_viewState == ViewState.Idle && _hasMore && _thressholdReached(index));
  }

  String indexStateTitle(){
    switch(indexState){
      case IndexState.Unfinished:
        return "Unfinished Tours";
        break;
      case IndexState.Finished:
        return "Finished Tours";
        break;
      case IndexState.Shared:
        return "Shared Tours";
        break;
    }
  }

  String dateFormater(String date){
    return formatter.format(DateTime.parse(date));
  }

  void setState(ViewState viewState){
    _viewState = viewState;
    notifyListeners();
  }

}