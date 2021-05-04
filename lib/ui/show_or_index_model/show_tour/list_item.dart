import 'package:flutter/material.dart';
import 'package:touring_by/core/models/point.dart';
import 'package:touring_by/ui/shared/widgets/custom_expandable_text.dart';
import 'package:transparent_image/transparent_image.dart';

class ListItem extends StatelessWidget {
  final Point point;
  ListItem({this.point});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: point.image,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    point.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CustomExpandableText(
                      text: point.description,
                      expandBreakPoint: 100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
