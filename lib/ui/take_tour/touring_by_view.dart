import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/viewmodels/touring_by_model.dart';
import 'package:touring_by/ui/shared/app_colors.dart';

class TouringByView extends StatefulWidget {
  @override
  _TouringByViewState createState() => _TouringByViewState();
}

class _TouringByViewState extends State<TouringByView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: SizedBox(
            height: 200,
            child: Container(
              color: primaryColor,
            ),
          ),
        ),

      ],
    );
  }
}
