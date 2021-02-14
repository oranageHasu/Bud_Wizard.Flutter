import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/services/api%20services/api-login.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/widgets/login/login.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-menu.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserIconMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DankIconMenu(
      icon: Icons.account_circle,
      menuItems: [
        IconMenuItem(
          'Change Password',
          Icons.lock_open,
          changePassword,
        ),
        IconMenuItem(
          'Account Settings',
          Icons.settings,
          editAccountSettings,
        ),
        IconMenuItem(
          'Log out',
          Icons.logout,
          performLogout,
        ),
      ],
      iconColor: (currentTheme.isDarkTheme())
          ? appBaseWhiteTextColor
          : appBaseBlackTextColor.withOpacity(0.8),
      menuHeaderChild: currentUserDisplay(),
      borderColor: (currentTheme.isDarkTheme())
          ? Colors.black.withOpacity(0.3)
          : Colors.black.withOpacity(0.6),
    );
  }

  Widget currentUserDisplay() {
    return Container(
      height: 60.0,
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.account_circle,
              color: (currentTheme.currentTheme() == ThemeMode.dark)
                  ? appBaseWhiteTextColor
                  : appBaseBlackTextColor,
              size: 30.0,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DankLabel(
                  displayText: 'Signed in as',
                  textStyle: appInputFontStyle.copyWith(
                    fontSize: 15.0,
                  ),
                ),
                DankLabel(
                  displayText: 'fart.tee77',
                  textStyle: appInputFontStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  padding: EdgeInsets.only(top: 5.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void changePassword() {
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

  void editAccountSettings() {
    log('To Do: Edit Account Settings.');
  }

  void performLogout() async {
    // Call API to perform logout
    bool opResult = await logout();

    // If successful? (we might not care) reroute the user to the Login
    if (opResult) {
      Get.off(LoginPage());
    }
  }
}
