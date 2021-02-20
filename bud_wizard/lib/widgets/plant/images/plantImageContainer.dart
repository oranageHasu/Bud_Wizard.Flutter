import 'dart:convert';
import 'package:bud_wizard/widgets/plant/images/plantImageDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantImageContainer extends StatelessWidget {
  final String base64Image;

  PlantImageContainer({
    @required String base64Image,
  }) : this.base64Image = base64Image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {selectPlantImage(context)},
      child: Container(
        width: 250.0,
        margin: EdgeInsets.all(2.5),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Image.memory(
          base64Decode(base64Image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void selectPlantImage(BuildContext context) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.7),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: PlantImageDialog(
              imgPath: 'assets/grow/img1.jpg',
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return SizedBox(height: 20.0);
      },
    );
  }
}
