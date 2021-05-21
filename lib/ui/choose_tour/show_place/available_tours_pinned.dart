import 'package:flutter/material.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/choose_tour/show_place/custom_persistent_header.dart';

class AvailableToursPinned extends StatelessWidget {
  final Widget itemCount;
  AvailableToursPinned({this.itemCount});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: CustomPersistentHeader(
        minExtent: 45.0,
        maxExtent: 60.0,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 3.0, color: primaryColor)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 3, right: 5, bottom: 0.0, top: 2.0),
                        child: Text(
                          "Available Tours",
                          style: TextStyle(
                            fontSize: 19.0,
                          ),
                        ),
                      ),
                    ),
                    this.itemCount,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
