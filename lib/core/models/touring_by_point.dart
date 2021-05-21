import 'dart:math';

import 'package:touring_by/core/models/point.dart';

class TouringByPoint {
  int id;
  bool like;
  bool hasImage;
  bool hasNext;
  Point point;

  // adding a random number to avoid image caching from not loading new image
  // maybe changing this with evict method later
  String get image => "touringbypoint/${this.id}/image?random=${Random().nextInt(1000).toString()}";

  TouringByPoint.fromJson(Map<String, dynamic> json){
    id = json['id'];
    like = json['like'];
    hasImage = json['hasImage'];
    hasNext = json['hasNext'];
    point = Point.fromJson(json['point']);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['like'] = this.like;
    data['hasImage'] = this.hasImage;
    data['hasNext'] = this.hasNext;
    data['point'] = this.point.toJson();
    return data;
  }
}
