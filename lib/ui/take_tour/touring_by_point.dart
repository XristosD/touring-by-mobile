import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/services/api_services/api_helpers.dart';
import 'package:touring_by/core/viewmodels/touring_by_model.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'dart:math';

class TouringByPoint extends StatelessWidget {
  const TouringByPoint({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TouringByModel>(
        builder: (context, model, child) {
          return Card(
            elevation: 3,
            child: Stack(
              children: [
                Center(
                  child: model.currentTouringByPoint.hasImage ?
                  FutureBuilder(
                    future: authenticationHeader,
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done){
                        return Image.network('$endpoint/${model.currentTouringByPoint.image}',
                          headers: Map.fromEntries([
                            snapshot.data,
                          ]),
                        );
                      }
                      else {
                        return Container();
                      }
                    },
                  ):
                  Image.network(model.currentTouringByPoint.point.image),
                ),
                AnimatedOpacity(
                  opacity: model.showDescrptionOpacity,
                  duration: const Duration(milliseconds: 500),
                  child: IgnorePointer(
                    ignoring: model.ignorePointerDescription,
                    child: Container(
                      color: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 15.0, right: 35.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 26.0, bottom: 13.0),
                                child: Text(
                                  model.currentTouringByPoint.point.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 5
                                  ),
                                ),
                              ),
                              Text(
                                model.currentTouringByPoint.point.description+model.currentTouringByPoint.point.description+model.currentTouringByPoint.point.description+model.currentTouringByPoint.point.description,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () => model.toggleLike(),
                          child: Icon(Icons.favorite, color: model.currentTouringByPoint.like ? Colors.red : primaryColor,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () => model.setImage(context),
                            child: Icon(Icons.camera_rounded, color: primaryColor,)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () => model.toggleShowDescription(),
                          child: Icon(Icons.info, color: primaryColor,),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}


