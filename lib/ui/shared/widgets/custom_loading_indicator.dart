import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Color color;
  CustomLoadingIndicator({this.color});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        color,
      ),
      strokeWidth: 5.0,
    );
  }
}
