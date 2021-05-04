import 'package:flutter/material.dart';
import 'package:touring_by/ui/shared/app_colors.dart';

class ListHeader extends SliverPersistentHeaderDelegate {
  ListHeader({ this.minExtent, @required this.maxExtent });
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            color: primaryColor,
          ),
        ),
        // Opacity(
        //   opacity: _imageOpacity(shrinkOffset),
        //   child: Image(image: AssetImage('assets/images/world_tour.png'))
        // ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8.0
                ),
              ),
              Text(
                "Select a place to inspect available tours",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // double _imageOpacity(double shrinkOffset) {
  //   // simple formula: fade out text as soon as shrinkOffset > 0
  //   return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  //   // more complex formula: starts fading out text when shrinkOffset > minExtent
  //   //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  // }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

// @override
// FloatingHeaderSnapConfiguration get snapConfiguration => null;
}