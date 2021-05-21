import 'package:flutter/material.dart';
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/services/api_services/choose_tour_api_service.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/custom_drawer.dart';
import 'package:touring_by/ui/shared/app_colors.dart';

class MainView extends StatelessWidget {
  final Widget body;
  MainView({@required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      //    TODO make back button primaryColor
          endDrawer: CustomDrawer(),
          appBar: AppBar(
            title: Text(
              "Touring-by",
              style: TextStyle(
                  fontFamily: 'Cormorant_Garamond',
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontSize: 26.0,
                  letterSpacing: 5.0),
            ),
          ),
          body: SafeArea(
            child: this.body,
      ),
    ));
  }
}
