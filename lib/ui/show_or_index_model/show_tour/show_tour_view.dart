import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/models/point.dart';
import 'package:touring_by/core/models/tour.dart';
import 'package:touring_by/core/viewmodels/show_tour_model.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/main_view.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';
import 'package:touring_by/ui/show_or_index_model/show_tour/list_item.dart';

class ShowTourView extends StatefulWidget {
  @override
  _ShowTourViewState createState() => _ShowTourViewState();
}

class _ShowTourViewState extends State<ShowTourView> {
  @override
  Widget build(BuildContext context) {
    final Tour tour = ModalRoute.of(context).settings.arguments as Tour;
    return MainView(
      body: ChangeNotifierProvider<ShowTourModel>(
        create: (context) => locator<ShowTourModel>(),
        child: Consumer<ShowTourModel>( builder: (context, model, child) {
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        if(model.timeToLoad(index)){
                          WidgetsBinding.instance.addPostFrameCallback((duration) {
                            model.loadMore(tour.id);
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
                          Point point = model.itemList[index];
                          return ListItem(point: point);
                        }
                      },
                      childCount: model.itemCount,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 14,
                right: 17,
                child: FloatingActionButton.extended(
                  icon: Icon(Icons.directions_walk),
                  label: Text("Start Tour"),
                  elevation: 10,
                ),
              ),
            ],
          );
        },),
      ),
    );
  }
}
