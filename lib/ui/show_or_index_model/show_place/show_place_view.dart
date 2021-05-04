import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/models/place.dart';
import 'package:touring_by/core/models/tour.dart';
import 'package:touring_by/core/viewmodels/show_place_model.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/main_view.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';
import 'package:touring_by/ui/show_or_index_model/show_place/list_item.dart';
import 'package:touring_by/ui/show_or_index_model/show_place/available_tours_pinned.dart';
import 'package:touring_by/ui/show_or_index_model/show_place/place_descripton.dart';
import 'package:touring_by/ui/show_or_index_model/show_place/place_image.dart';
import 'package:touring_by/ui/show_or_index_model/show_place/place_name_pinned.dart';
import 'package:touring_by/ui/show_or_index_model/show_place/tour_list.dart';

class ShowPlaceView extends StatefulWidget {
  @override
  _ShowPlaceViewState createState() => _ShowPlaceViewState();
}

class _ShowPlaceViewState extends State<ShowPlaceView> {
  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context).settings.arguments as Place;
    return MainView(
      body: ChangeNotifierProvider<ShowPlaceModel>(
        create: (context) => locator<ShowPlaceModel>(),
        child: Consumer<ShowPlaceModel>(
          builder: (context, model, child) {
            return CustomScrollView(
              slivers: [
                placeImage(placeImg: place.image),
                placeNamePinned(placeName: place.name),
                placeDescription(placeDescr: place.description),
                AvailableToursPinned(
                  itemCount: model.itemCount == null
                      ? Container()
                      : Text(
                          model.itemCount.toString(),
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                ),
                TourList(
                  passedInitState: () {
                    if (model.initialLoad) {
                      WidgetsBinding.instance.addPostFrameCallback((duration) {
                        model.load(place.id);
                      });
                    }
                  },
                  child: model.state == ViewState.Busy
                      ? SliverFillRemaining(
                          child: Center(child: SizedBox(child: CustomLoadingIndicator(),
                          height: 35,)),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                Tour tour = model.itemList[index];
                            return ListItem(tour: tour);
                          }, childCount: model.itemCount),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
