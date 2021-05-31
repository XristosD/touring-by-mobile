import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/viewmodels/touring_by_model.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';
import 'package:touring_by/ui/take_tour/custom_rounded_button.dart';
import 'package:touring_by/ui/take_tour/touring_by_point.dart';
import 'package:touring_by/ui/take_tour/touring_by_point_parent.dart';
import 'package:touring_by/ui/take_tour/touring_by_point_welcome.dart';
import 'package:url_launcher/url_launcher.dart';

class TouringByView extends StatefulWidget {
  @override
  _TouringByViewState createState() => _TouringByViewState();
}

class _TouringByViewState extends State<TouringByView> {

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng( 37.973634, 23.719592),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
            child: Consumer<TouringByModel>(
              builder: (context, model, child){
                return Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height/3,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        markers: model.currentTouringByPoint != null ?
                        {
                          Marker(
                              markerId: MarkerId(model.currentTouringByPoint.id.toString()),
                              position: LatLng(model.currentTouringByPoint.point.latitude, model.currentTouringByPoint.point.longitude)
                          )
                        } :
                        null,
                        onMapCreated: (GoogleMapController controller) {
                          if(!model.controller.isCompleted){
                            model.controller.complete(controller);
                          }
                        },
                      ),
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: TextButton(
                          onPressed: () async {
                            final url = 'https://www.google.com/maps/search/?api=1&query=${model.currentTouringByPoint.point.latitude},${model.currentTouringByPoint.point.longitude}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                            else{
                              print("not launched");
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "maps",
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor
                                ),
                              ),
                              SizedBox(width: 3,),
                              Icon(Icons.map_rounded, color: primaryColor, size: 15.0,)
                            ],
                          ),
                          style: TextButton.styleFrom(
                            primary: primaryColor,
                          ),
                        )
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<TouringByModel>(context, listen: false).getCurrentTouringByPoint(),
              builder: (context, snapshot) {
                Widget child;
                if(snapshot.connectionState == ConnectionState.done){
                  child =  TouringByPointParent(
                    key: ValueKey(1),
                    child: TouringByPoint(),
                  );
                }
                else {
                  child = TouringByPointParent(
                    key: ValueKey(2),
                    child: TouringByPointWelcome(),
                  );
                }
                return AnimatedSwitcher(
                  duration: Duration(seconds: 3),
                  child: child,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Consumer<TouringByModel>(
              builder: (context, model, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomRoundedButton(
                      icon: Icons.stop,
                      label: "FINISH",
                      iconLeading: true,
                      loadingIndicator: CustomLoadingIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      ),
                      showLoadingIndicator: model.state==ViewState.Completing ? true : false,
                      action: () async {
                        if(await model.finishTouringBy()){
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/show_touring_by',
                            ModalRoute.withName('/'),
                            arguments: model.touringBy.id
                          );
                          // Navigator.pushNamed(context, '/');
                        }
                      },
                    ),
                    CustomRoundedButton(
                      icon: Icons.fast_forward_outlined,
                      label: "SKIP",
                      iconLeading: false,
                      loadingIndicator: CustomLoadingIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                        ),
                      showLoadingIndicator: model.state==ViewState.Skipping ? true : false,
                      action: () => model.state==ViewState.Idle ? model.nextTouringByPoint(true) : null,
                    ),
                    CustomRoundedButton(
                      icon: Icons.navigate_next_rounded,
                      label: "NEXT",
                      iconLeading: false,
                      loadingIndicator: CustomLoadingIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      ),
                      showLoadingIndicator: model.state==ViewState.GettingNext ? true : false,
                      action: () => model.state==ViewState.Idle ? model.nextTouringByPoint(false) : null,
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

