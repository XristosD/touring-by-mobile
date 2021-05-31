import 'package:flutter/material.dart';
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/services/api_services/show_touring_by_api_service.dart';
import 'package:touring_by/locator.dart';
import 'package:intl/intl.dart';

enum ViewState {Idle, Busy}

class ShowTouringByModel extends ChangeNotifier {
  Map<String, dynamic> _data;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  List<dynamic> get touringByPoints => _data['touring_by_point'];
  String get placeName => _data['tour']['place']['name'];
  String get placeImage => _data['tour']['place']['image'];
  String get tourName => _data['tour']['name'];
  String get date => formatter.format(DateTime.parse(_data['created_at']));
  String get userName => _data['user']['name'];
  bool get ownerTouringBy  => _data['user']['owner'];
  bool get resumeTouringByOption => _data['user']['owner'] && !_data['completed'];

  Future initiallizeData({int touringById}) async {
    ApiResponse response;

    response = await locator<ShowTouringByApiService>().showTouringBy(touringById);
    if(response.success){
      _data = Map<String, dynamic>.from(response.body);
    }
    else{
      print(response.body.toString());
    }
  }


}