class Tour {
  int id;
  String name;
  String description;
  int pointsCount;
  Tour({this.id, this.name, this.description, this.pointsCount});

  Tour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pointsCount = json['points_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['points_count'] = this.pointsCount;
    return data;
  }
}