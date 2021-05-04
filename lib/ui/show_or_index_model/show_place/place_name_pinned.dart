import 'package:flutter/material.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/show_or_index_model/show_place/custom_persistent_header.dart';

class placeNamePinned extends StatelessWidget {
  const placeNamePinned({
    Key key,
    @required this.placeName,
  }) : super(key: key);

  final String placeName;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: CustomPersistentHeader(
        minExtent: 40.0,
        maxExtent: 60.0,
        child: Container(
          color: primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                placeName,
                style:
                TextStyle(color: Colors.white, fontSize: 24.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}