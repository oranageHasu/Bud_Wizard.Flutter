import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/services/loggerService.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-menu.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class PlantIconMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DankIconMenu(
      icon: CommunityMaterialIcons.cannabis,
      menuItems: [
        IconMenuItem(
          'Add Journal Entry',
          Icons.edit,
          addJournalEntry,
        ),
        IconMenuItem(
          'Upload Plant Photo',
          Icons.add_a_photo,
          uploadPlantImage,
        ),
        IconMenuItem(
          'Start New Grow',
          Icons.add,
          startNewGrow,
        ),
        IconMenuItem(
          'Delete Current Grow',
          Icons.delete_forever,
          deleteGrow,
        ),
      ],
      iconColor: (currentTheme.isDarkTheme())
          ? appBaseWhiteTextColor
          : appBaseBlackTextColor.withOpacity(0.8),
      borderColor: Colors.black.withOpacity(0.3),
    );
  }

  void addJournalEntry() {
    log('To Do: Add Journal Entry');
  }

  void uploadPlantImage() {
    log('To Do: Upload Plant Image');
  }

  void startNewGrow() {
    log('To Do: Start New Grow.');
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

  void deleteGrow() {
    log('To Do: Delete Grow.');
  }
}
