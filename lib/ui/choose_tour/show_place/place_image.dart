
import 'package:flutter/material.dart';

class placeImage extends StatelessWidget {
  const placeImage({
    Key key,
    @required this.placeImg,
  }) : super(key: key);

  final String placeImg;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 15),
      sliver: SliverToBoxAdapter(
        child: Container(
          child: Image.network(placeImg),
        ),
      ),
    );
  }
}