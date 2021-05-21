import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/models/touring_by_initial_state.dart';
import 'package:touring_by/core/viewmodels/touring_by_model.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';
import 'package:touring_by/ui/take_tour/touring_by_view.dart';

class InitialLoadView extends StatelessWidget {
  final TouringByInitialState touringByInitialState;
  const InitialLoadView({
    @required this.touringByInitialState,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TouringByModel>(context, listen: false).initiallizeTouringBy(
        touringByInitialState: this.touringByInitialState,
        scaffold: Scaffold.of(context),
      ),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return TouringByView();
        }
        else{
          return Center(child: CustomLoadingIndicator());
        }
      },
    );
  }
}