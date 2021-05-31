import 'package:flutter/material.dart';
import 'package:touring_by/core/services/shared_preferences_service.dart';
import 'package:touring_by/core/services/user_service.dart';
import 'package:touring_by/ui/authentication/views/login_view.dart';
import 'package:touring_by/ui/authentication/views/register_view.dart';
import 'package:touring_by/ui/choose_tour/index_place/index_place_view.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/choose_tour/show_place/show_place_view.dart';
import 'package:touring_by/ui/choose_tour/show_tour/show_tour_view.dart';
import 'package:touring_by/ui/show_touring_by/share_touring_by_view.dart';
import 'package:touring_by/ui/show_touring_by/show_touring_by_view.dart';
import 'package:touring_by/ui/index_touring_by/index_touring_by_view.dart';
import 'package:touring_by/ui/take_tour/take_tour_view.dart';

import 'core/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  final bool hasUser = await locator<UserService>().hasUser();
  runApp(MyApp(
    hasUser: hasUser,
  ));
}

class MyApp extends StatelessWidget {
  final bool hasUser;

  MyApp({this.hasUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: primaryColor,
      debugShowCheckedModeBanner: false,
      title: 'Touring-By',
      theme: ThemeData(
        // primarySwatch: createMaterialColor(primaryColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.white,
        accentColor: primaryColor,
        shadowColor: primaryColor,
        appBarTheme: AppBarTheme(
          elevation: 15.0,
          shadowColor: primaryColor,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: primaryColor,
          )
        ),
      ),
      //home: RegisterView(),
      initialRoute: hasUser ? '/' : '/login',
      // initialRoute: '/',
      routes: {
        '/': (context) => IndexPlaceView(),
        '/register': (context) => RegisterView(),
        '/login': (context) => LoginView(),
        '/show_place': (context) => ShowPlaceView(),
        '/show_tour': (context) => ShowTourView(),
        '/take_tour': (context) => TakeTourView(),
        '/show_touring_by': (context) => ShowTouringByView(),
        '/share_touring_by' : (context) => ShareTouringByView(),
        '/index_touring_by' : (context) => IndexTouringByView()
      },
    );
  }
}
