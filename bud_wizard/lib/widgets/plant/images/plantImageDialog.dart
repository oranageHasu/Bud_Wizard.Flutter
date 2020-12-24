import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-button.dart';
import 'package:flutter/material.dart';

class PlantImageDialog extends StatelessWidget {
  final String imgPath;

  PlantImageDialog({
    String imgPath,
  }) : this.imgPath = imgPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dialog(
            clipBehavior: Clip.antiAlias,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 16,
            child: new GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      imgPath,
                      fit: BoxFit.none,
                    ),
                  ],
                ),
              ),
            ),
          ),
          DankIconButton(
            iconData: Icons.close,
            tooltipText: '',
            displayTooltip: false,
            iconSize: 25.0,
            onPressed: () => {dismissDialog(context)},
          ),
        ],
      ),
    );
  }

  void dismissDialog(BuildContext context) async {
    Navigator.pop(context);
  }
}
