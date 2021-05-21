import 'package:flutter/material.dart';

class TouringByPointParent extends StatelessWidget {
  final Widget child;
  const TouringByPointParent({
    @required this.child,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
      child: child,
    );
  }
}