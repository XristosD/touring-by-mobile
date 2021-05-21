import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/models/tour.dart';
import 'package:touring_by/core/models/touring_by_initial_state.dart';
import 'package:touring_by/core/viewmodels/touring_by_model.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/main_view.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';
import 'package:touring_by/ui/take_tour/initial_load_view.dart';

class TakeTourView extends StatefulWidget {
  @override
  _TakeTourViewState createState() => _TakeTourViewState();
}

class _TakeTourViewState extends State<TakeTourView> {
  @override
  Widget build(BuildContext context) {
    final TouringByInitialState touringByInitialState = ModalRoute.of(context).settings.arguments as TouringByInitialState;
    return ChangeNotifierProvider<TouringByModel>(
      create: (context) => locator<TouringByModel>(),
      builder: (context, child) {
        return MainView(
          body: InitialLoadView(touringByInitialState: touringByInitialState,),
        );
      }
    );
  }
}


