

class TouringByInitialState {
  int tourId;
  int touringById;

  TouringByInitialState({this.tourId, this.touringById});

  bool get newTouringBy => this.touringById == null;
}