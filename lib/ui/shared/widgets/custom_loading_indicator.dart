import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  CustomLoadingIndicator({this.color, this.strokeWidth = 5.0});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        color,
      ),
      strokeWidth: this.strokeWidth,
    );
  }
}
