import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/models/place.dart';
import 'package:touring_by/core/viewmodels/index_place_model.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/main_view.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';
import 'package:touring_by/ui/choose_tour/index_place/list_header.dart';
import 'package:touring_by/ui/choose_tour/index_place/list_item.dart';

class IndexPlaceView extends StatefulWidget {
  @override
  _IndexPlaceViewState createState() => _IndexPlaceViewState();
}

class _IndexPlaceViewState extends State<IndexPlaceView> {
  @override
  Widget build(BuildContext context) {
    return MainView(
        body: ChangeNotifierProvider<IndexPlaceModel>(
      create: (context) => locator<IndexPlaceModel>(),
      child: Consumer<IndexPlaceModel>(builder: (context, model, child) {
        return CustomScrollView(
          // TODO try to make view and viesmodel generic
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(top: 15.0),
              sliver: SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: ListHeader(
                  minExtent: MediaQuery.of(context).size.height / 10,
                  maxExtent: MediaQuery.of(context).size.height / 5,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              if (model.timeToLoad(index)) {
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  model.loadMore();
                });
              }
              if (model.indicatorAdded(index)) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: CustomLoadingIndicator(
                      color: primaryColor,
                    ),
                  ),
                );
              } else {
                Place place = model.itemList[index];
                return ListItem(place: place);
              }
            }, childCount: model.itemCount)),
          ],
        );
      }),
    ));
  }
}

//
// Infinite scroll listview Swaped with custom scrollview to implement sliverAppBar
//
// Column(
// children: [
// Padding(
// padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
// child: Column(
// children: [
// // TODO make list header look better
// Text("Welcome"),
// Text("Select a place to begin your tour")
// ],
// ),
// ),
// Expanded(
// child: ListView.builder(
// itemCount: model.itemCount,
// itemBuilder: (context, index) {
// if (model.timeToLoad(index)) {
// WidgetsBinding.instance
//     .addPostFrameCallback((duration) {
// model.loadMore();
// });
// }
// if (model.indicatorAdded(index)) {
// // print("indicator");
// return Padding(
// padding: const EdgeInsets.all(18.0),
// child: Center(
// child: CustomLoadingIndicator(
// color: primaryColor,
// ),
// ),
// );
// }
// Place place = model.itemList[index];
// return Padding(
// padding: const EdgeInsets.all(2.0),
// child: Card(
// elevation: 4,
// child: Column(
// children: [
// Image.network(place.image),
// Padding(
// padding: const EdgeInsets.all(18.0),
// child: Text(place.description),
// ),
// ],
// ),
// ),
// );
// })),
// ],
// );
