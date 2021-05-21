

import 'package:flutter/cupertino.dart';

class CustomPersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minExtent;
  final double maxExtent;
  CustomPersistentHeader({@required this.minExtent, @required this.maxExtent, @required this.child});


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }


  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}