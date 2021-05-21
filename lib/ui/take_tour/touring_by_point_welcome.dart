import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/viewmodels/touring_by_model.dart';
import 'package:touring_by/ui/shared/app_colors.dart';

class TouringByPointWelcome extends StatelessWidget {
  const TouringByPointWelcome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Text(
          Provider.of<TouringByModel>(context, listen: false).touringBy.tour.name,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              color: Colors.white
          ),
        ),
      ),
    );
  }
}
