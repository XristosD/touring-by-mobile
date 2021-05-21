import 'package:flutter/material.dart';

class TourList extends StatefulWidget {
  final VoidCallback passedInitState;
  final Widget child;
  TourList({this.passedInitState, this.child});
  @override
  _tourListState createState() => _tourListState();
}

class _tourListState extends State<TourList> {

  void initState() {
    super.initState();
    this.widget.passedInitState();
  }
  @override
  Widget build(BuildContext context) {
    return this.widget.child;
  }
}