import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bud_wizard/classes/enumerations.dart';

import '../../main.dart';
import 'navigationTile.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Container(
        color: Colors.black87,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              accountName: Text("Oranagehasu", style: TextStyle(color: Colors.white)),
              accountEmail: Text("Oranagehasu@gmail.com", style: TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/full_breakpoints_theme_medicaldaily_desktop_1x/public/2016/04/05/marijuana.jpg'),
              ),
            ),
            Divider(
              height: 0.1,
              color: Colors.white,
            ),
            NavigationTile(displayedText:"Messages", screen: Screen.messages),
            NavigationTile(displayedText:"Grows", screen: Screen.grows),
            NavigationTile(displayedText:"Social", screen: Screen.social),
            NavigationTile(displayedText:"Knowledge Base", screen: Screen.knowledgeBase),
            NavigationTile(displayedText:"Settings", screen: Screen.settings),
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
                  title: new Text('Logout', style: TextStyle(color: Colors.white)),
                  leading: new Icon(Icons.logout, color: Colors.white),
                  tileColor: Colors.black12,
                  hoverColor: colorCustom.shade50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void performLogout() async {

  }

  void navigateTo(Screen screen) {

  }
}