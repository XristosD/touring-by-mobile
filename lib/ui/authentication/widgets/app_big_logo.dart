import 'package:flutter/material.dart';
import 'package:touring_by/ui/shared/app_colors.dart';

class AppBigLogo extends StatelessWidget {
  double width;
  double height;
  AppBigLogo({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(this.width/8.5, this.height/4, 0.0, this.height/8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Touring-by',
              style: TextStyle(
                fontSize: this.height/15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cormorant_Garamond',
              ),
            ),
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: (this.height/15)*4.5),
            duration: Duration(milliseconds: 1800),
            curve: Curves.easeOutQuad,
            builder: (BuildContext context, double _width , _ ){
              return Container(
                  height: 3,
                  width: _width,
                  color: primaryColor,
                  margin: EdgeInsets.only(top: 5.0),
              );
            },
          )
        ],
      ),
    );
  }
}
