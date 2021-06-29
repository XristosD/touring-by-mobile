import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:touring_by/core/models/tour.dart';
import 'package:touring_by/core/models/touring_by_initial_state.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/shared/widgets/custom_expandable_text.dart';

class ListItem extends StatefulWidget {
  final Tour tour;
  ListItem({@required this.tour});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> with AutomaticKeepAliveClientMixin  {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 6, right: 2),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.tour.name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.tour.rating,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 20.0,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8, left: 2, right: 6),
                      child: GestureDetector(
                        onTap: () { Navigator.pushNamed(context, "/show_tour", arguments: widget.tour); },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "check ${widget.tour.pointsCount.toString()} point${widget.tour.pointsCount == 1 ? '' : 's'}",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                              ),
                            ),
                            Icon(
                              Icons.arrow_right,
                              color: primaryColor,
                              size: 23,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: GestureDetector(
                      onTap: () { Navigator.pushNamed(context, "/take_tour", arguments: TouringByInitialState(tourId: widget.tour.id)); },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_walk,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Start Tour",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 6, right: 6),
                  child: CustomExpandableText(
                    text: widget.tour.description,
                    expandBreakPoint: 150,
                  ),
                )
                // Padding(
                //   padding: const EdgeInsets.only(top: 8, bottom: 8, left: 6, right: 6),
                //   child: Text(tour.description),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}






