import 'package:flutter/material.dart';

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
          ),
          Divider(
            height: 0.1,
          ),
          ListTile(
            title: new Text("Grows"),
            leading: new Icon(Icons.inbox),
          ),
          ListTile(
            title: new Text("Social"),
            leading: new Icon(Icons.people),
          ),
          ListTile(
            title: new Text("Knowledge Base"),
            leading: new Icon(Icons.info),
          ),
          ListTile(
            title: new Text("Settings"),
            leading: new Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}