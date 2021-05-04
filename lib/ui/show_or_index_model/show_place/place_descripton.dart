import 'package:flutter/material.dart';
import 'package:touring_by/ui/shared/app_colors.dart';

class placeDescription extends StatelessWidget {
  const placeDescription({
    Key key,
    @required this.placeDescr,
  }) : super(key: key);

  final String placeDescr;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 3.0, color: primaryColor))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 3, right: 5, bottom: 0.0, top: 2.0),
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 19.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(placeDescr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}