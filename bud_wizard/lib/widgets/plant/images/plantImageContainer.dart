import 'package:bud_wizard/widgets/plant/images/plantImageDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantImageContainer extends StatelessWidget {
  final String imgPath;

  PlantImageContainer({
    String imgPath,
  }) : this.imgPath = imgPath;

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
        child: Image.asset(
          imgPath,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  void selectPlantImage(BuildContext context) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: PlantImageDialog(
              imgPath: imgPath,
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
