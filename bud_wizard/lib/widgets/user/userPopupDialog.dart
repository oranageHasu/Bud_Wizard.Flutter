import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/services/api%20services/api-login.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-popup-menu.dart';
import 'package:flutter/material.dart';

class UserPopupDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DankPopupMenu(
      margin: EdgeInsets.only(right: 15.0),
      items: [
        DankDropdownItem(
          'Change Password',
          Icons.lock_open,
          changePassword,
        ),
        DankDropdownItem(
          'Account Settings',
          Icons.settings,
          editAccountSettings,
        ),
        DankDropdownItem(
          'Logout',
          Icons.logout,
          performLogout,
        ),
      ],
    );
  }

  void changePassword(BuildContext context) {
    log('To Do: Change Password.');
    /*
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: UserPasswordResetDialog(),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return SizedBox(height: 20.0);
      },
    );
    */
  }

  void editAccountSettings(BuildContext context) {
    log('To Do: Edit Account Settings.');
  }

  void performLogout(BuildContext context) async {
    // Call API to perform logout
    bool opResult = await logout();

    // If successful? (we might not care) reroute the user to the Login
    if (opResult) {
      Navigator.pushReplacementNamed(context, uiRouteLogin);
    }
  }
}
