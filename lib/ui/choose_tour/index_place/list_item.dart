


import 'package:flutter/material.dart';
import 'package:touring_by/core/models/place.dart';
import 'package:transparent_image/transparent_image.dart';

class ListItem extends StatelessWidget {
  final Place place;
  ListItem({@required this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/show_place", arguments: place);
        },
        child: Card(
          elevation: 4,
          child: Column(
            children: [
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: place.image,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(place.description),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
