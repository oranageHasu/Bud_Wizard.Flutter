import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../main.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Oranagehasu"),
            accountEmail: Text("Oranagehasu@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/full_breakpoints_theme_medicaldaily_desktop_1x/public/2016/04/05/marijuana.jpg'),
            ),
            otherAccountsPictures: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage('https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/full_breakpoints_theme_medicaldaily_desktop_1x/public/2016/04/05/marijuana.jpg'),
              )
            ],
          ),
          ListTile(
            title: new Text("Messages"),
            leading: new Icon(Icons.mail),
            hoverColor: colorCustom.shade50,
            onTap: () {
              print('To Do: Messages.');
            },
          ),
          Divider(
            height: 0.1,
          ),
          ListTile(
            title: new Text("Grows"),
            leading: new Icon(Icons.inbox),
            hoverColor: colorCustom.shade50,
            onTap: () {
              print('To Do: Grows.');
            },
          ),
          ListTile(
            title: new Text("Social"),
            leading: new Icon(Icons.people),
            hoverColor: colorCustom.shade50,
            onTap: () {
              print('To Do: Social.');
            },
          ),
          ListTile(
            title: new Text("Knowledge Base"),
            leading: new Icon(Icons.info),
            hoverColor: colorCustom.shade50,
            onTap: () {
              print('To Do: Knowledge Base.');
            },
          ),
          ListTile(
            title: new Text("Settings"),
            leading: new Icon(Icons.settings),
            hoverColor: colorCustom.shade50,
            onTap: () {
              print('To Do: Settings.');
            },
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                onTap: () async {

                  // To Do: Call API to perform logout

                  Navigator.pushReplacementNamed(
                      context,
                      '/Login'
                  );
                },
                title: new Text('Logout'),
                leading: new Icon(Icons.logout),
                tileColor: Colors.black12,
                hoverColor: colorCustom.shade50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void performLogout() async {

  }
}