import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/services/api_services/api_helpers.dart';
import 'package:touring_by/core/viewmodels/show_tour_model.dart';
import 'package:touring_by/core/viewmodels/show_touring_by_model.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/main_view.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';

class ShowTouringByView extends StatefulWidget {
  @override
  _ShowTouringByViewState createState() => _ShowTouringByViewState();
}

class _ShowTouringByViewState extends State<ShowTouringByView> {
  @override
  Widget build(BuildContext context) {
    final int touringById = ModalRoute.of(context).settings.arguments as int;
    return MainView(
        body: ChangeNotifierProvider<ShowTouringByModel>(
          create: (context) => locator<ShowTouringByModel>(),
          builder: (context, child)  {
            return FutureBuilder(
              future: Provider.of<ShowTouringByModel>(context, listen: false).initiallizeData(touringById: touringById),
              builder: (context, snapShot){
                if(snapShot.connectionState == ConnectionState.done){
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        actions: [Container()],
                        backgroundColor: primaryColor,
                        pinned: false,
                        floating: false,
                        expandedHeight: MediaQuery.of(context).size.height*4/5,
                        // collapsedHeight: 101.0,
                        titleSpacing: 0.0,
                        toolbarHeight: 120.0,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Provider.of<ShowTouringByModel>(context, listen: false).resumeTouringByOption ?
                                  MaterialButton(
                                    minWidth: 0,
                                    onPressed: () {},
                                    elevation: 2.0,
                                    color:  Colors.white,
                                    // fillColor: primaryColor,
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 25.0,
                                      color: primaryColor,
                                    ),
                                    // padding: EdgeInsets.all(8.0),
                                    shape: CircleBorder(),
                                  ) : Container(),
                                  Provider.of<ShowTouringByModel>(context, listen: false).ownerTouringBy ?
                                  MaterialButton(
                                    minWidth: 0,
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/share_touring_by', arguments: touringById);
                                    },
                                    elevation: 2.0,
                                    // fillColor: primaryColor,
                                    child: Icon(
                                      Icons.share,
                                      size: 25.0,
                                      color: primaryColor,

                                    ),
                                    // padding: EdgeInsets.all(8.0),
                                    shape: CircleBorder(),
                                  ) : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          centerTitle: true,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 30, left: 8.0, right: 8.0),
                                  child: RichText(
                                    overflow : TextOverflow.fade,
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                      children: [
                                        TextSpan(text: "This is\n"),
                                        TextSpan(
                                          text: "${Provider.of<ShowTouringByModel>(context, listen: false).tourName}\n",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          )
                                        ),
                                        Provider.of<ShowTouringByModel>(context, listen: false).ownerTouringBy ?
                                        TextSpan(text: "") :
                                        TextSpan(text: "from ${Provider.of<ShowTouringByModel>(context, listen: false).userName} "),
                                        TextSpan(text: "on ${Provider.of<ShowTouringByModel>(context, listen: false).date}\n"),
                                        TextSpan(text: "at "),
                                        TextSpan(
                                          text: "${Provider.of<ShowTouringByModel>(context, listen: false).placeName}",
                                          style: TextStyle(
                                            fontSize: 20.0
                                          )
                                        ),
                                      ]
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.network(
                                Provider.of<ShowTouringByModel>(context, listen: false).placeImage,
                                fit: BoxFit.fitHeight,
                              ),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black26
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                        Map<String, dynamic> touringByPoint = Provider.of<ShowTouringByModel>(context, listen: false).touringByPoints[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: 30
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          touringByPoint['point']['name'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: touringByPoint['hasImage'] ?
                                      FutureBuilder(
                                        future: authenticationHeader,
                                        builder: (context, snapshot) {
                                          if(snapshot.connectionState == ConnectionState.done){
                                            return Image.network('$endpoint/touringbypoint/${touringByPoint['id']}/image',
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
                                      Image.network(touringByPoint['point']['image']),
                                    ),
                                    touringByPoint['like']?
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Container(
                                        child: Icon(Icons.favorite, color: Colors.red, size: 30,),
                                      ),
                                    ):
                                    Container(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },childCount: Provider.of<ShowTouringByModel>(context, listen: false).touringByPoints.length
                      ))
                    ],
                  );
                }
                else{
                  return Center(child: CustomLoadingIndicator(),);
                }
              },
            );
          },
        ),
    );
  }
}
