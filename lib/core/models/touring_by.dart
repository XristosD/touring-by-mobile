import 'package:touring_by/core/models/tour.dart';

class TouringBy {
  int id;
  Tour tour;

  TouringBy.fromJson(Map<String, dynamic> json){
    id = json['id'];
    tour = Tour.fromJson(json['tour']);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tour'] = this.tour.toJson();
    return data;
  }
}