import 'package:flutter/material.dart';
import 'package:touring_by/core/models/user.dart';
import 'package:touring_by/core/services/user_service.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/shared/app_colors.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future _getUser = locator<UserService>().getUser();
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                ),
                ListTile(
                  title: Text("finished", style: TextStyle(fontSize: 18.0, color: primaryColor),),
                ),
                ListTile(
                  title: Text("Shared", style: TextStyle(fontSize: 18.0, color: primaryColor),),
                ),
              ],
            ),
          ),
          Divider(thickness: 1, color: primaryColor,),
          ListTile(
            title: Text("Log out", style: TextStyle(fontSize: 20.0, color: primaryColor),),
          ),
        ],
      ),
    );
  }
}
