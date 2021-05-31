import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/enums/index_state.dart';
import 'package:touring_by/core/models/user.dart';
import 'package:touring_by/core/services/user_service.dart';
import 'package:touring_by/core/viewmodels/logout_model.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future _getUser = locator<UserService>().getUser();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColor
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    child: FutureBuilder(
                      future: _getUser,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data.name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white
                                ),
                              ),
                              Text(
                                snapshot.data.email,
                                style: TextStyle(
                                  color: Colors.white70
                                ),
                              )
                            ],
                          );
                        }
                        else{
                          return Container();
                        }
                      }
                    ),
                  ),
                ]
              )
            ),
            ListTile(
              title: Text("Start a new tour", style: TextStyle(fontSize: 20.0, color: primaryColor),),
            ),
            Divider(thickness: 1, color: primaryColor,),
            ListTile(
              title: Text("Index your tours", style: TextStyle(fontSize: 20.0, color: primaryColor),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Unfinished", style: TextStyle(fontSize: 18.0, color: primaryColor),),
                    onTap: () {
                      if(ModalRoute.of(context).settings.name == '/index_touring_by'){
                        Navigator.of(context).pushReplacementNamed('/index_touring_by',arguments: IndexState.Unfinished);
                      }
                      Navigator.of(context).popAndPushNamed(
                        '/index_touring_by',
                        arguments: IndexState.Unfinished
                      );
                      // Navigator.pop(context);
                      }  ,
                  ),
                  ListTile(
                    title: Text("finished", style: TextStyle(fontSize: 18.0, color: primaryColor),),
                      onTap: () {
                        if(ModalRoute.of(context).settings.name == '/index_touring_by'){
                          Navigator.of(context).pushReplacementNamed('/index_touring_by',arguments: IndexState.Finished);
                        }
                        Navigator.of(context).popAndPushNamed(
                            '/index_touring_by',
                            arguments: IndexState.Finished
                        );
                        // Navigator.pop(context);
                      }
                  ),
                  ListTile(
                    title: Text("Shared", style: TextStyle(fontSize: 18.0, color: primaryColor),),
                      onTap: () {
                      if(ModalRoute.of(context).settings.name == '/index_touring_by'){
                        Navigator.of(context).pushReplacementNamed('/index_touring_by',arguments: IndexState.Shared);
                      }
                        Navigator.of(context).popAndPushNamed(
                            '/index_touring_by',
                            arguments: IndexState.Shared
                        );
                        // Navigator.pop(context);
                      }
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: primaryColor,),
            ChangeNotifierProvider<LogoutModel>(
            create: (context) => locator<LogoutModel>(),
            builder: (context, child) {
              return Consumer<LogoutModel>(
                builder: (context, model, child){
                  return   ListTile(
                    title: model.state == ViewState.Idle ?
                    Text("Log out", style: TextStyle(fontSize: 20.0, color: primaryColor),) :
                    Center(child: CustomLoadingIndicator(),),
                    onTap: () async {
                      if( await model.logout()){
                        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                      }
                      else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Logout couldn't complete.", style: TextStyle(color: primaryColor),),
                          duration: Duration(seconds: 3),
                        ));
                      }
                    },
                  );
                },
              );
            },
            ),
            // ListTile(
            //   title: Text("Log out", style: TextStyle(fontSize: 20.0, color: primaryColor),),
            // ),
          ],
        ),
      ),
    );
  }
}
