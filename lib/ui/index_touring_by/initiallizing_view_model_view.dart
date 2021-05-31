import 'package:flutter/material.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';

class InitializingViewModelView extends StatefulWidget {
  final Function viewModelInitializer;
  final Widget loadedView;
  final Widget loadingView;
  InitializingViewModelView({this.viewModelInitializer, this.loadedView, this.loadingView});
  @override
  _InitializingViewModelViewState createState() => _InitializingViewModelViewState();
}

class _InitializingViewModelViewState extends State<InitializingViewModelView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.widget.viewModelInitializer(),
      builder: (context, snapShot) {
        if(snapShot.connectionState == ConnectionState.done){
          return this.widget.loadedView;
        }
        else{
          return this.widget.loadingView;
        }
      }
    );
  }
}
