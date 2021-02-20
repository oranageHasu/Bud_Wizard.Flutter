import 'dart:convert';

import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-button.dart';
import 'package:flutter/material.dart';

class PlantImageDialog extends StatelessWidget {
  final String base64Image;

  PlantImageDialog({
    String base64Image,
  }) : this.base64Image = base64Image;

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
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.memory(
                      base64Decode(base64Image),
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
            buttonType: DankButtonType.Outline,
            outlineColor: Colors.transparent,
          ),
        ],
      ),
    );
  }

  void dismissDialog(BuildContext context) async {
    Navigator.pop(context);
  }
}
