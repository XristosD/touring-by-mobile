class Point {
  int id;
  String name;
  String description;
  String image;
  double latitude;
  double longitude;
  Point({this.id, this.name, this.description, this.latitude, this.longitude, this.image});

  Point.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image'] = this.image;
    return data;
  }
}