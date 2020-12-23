import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageDialog.dart';
import 'package:bud_wizard/widgets/plant/plantCard.dart';
import 'package:bud_wizard/widgets/plant/plantWeekSelector.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantDetail extends StatefulWidget {
  final Plant currentPlant;

  PlantDetail({
    Plant plant,
  }) : this.currentPlant = plant;

  @override
  _PlantDetailState createState() => _PlantDetailState(this.currentPlant);
}

class _PlantDetailState extends State<PlantDetail> {
  Plant currentPlant;

  _PlantDetailState(
    this.currentPlant,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(PlantDetail oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentPlant != widget.currentPlant) {
      currentPlant = widget.currentPlant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appSecondColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          DankLabel(
            displayText: currentPlant.name,
            textAlign: TextAlign.left,
            textStyle: appHeaderFontStyle.copyWith(
              fontSize: 22.0,
              color: appBaseColor.withOpacity(0.9),
            ),
            padding: EdgeInsets.only(
              left: 15.0,
              top: 10.0,
            ),
          ),
          PlantCard(
            plant: currentPlant,
            isFeatured: true,
            isSelectable: false,
          ),
          PlantWeekSelector(plant: currentPlant),
          imageSelector(),
          Expanded(
            child: Container(
              color: appSecondColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget imageSelector() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 150.0,
        color: appThirdColor,
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            imageContainer('grow/img1.jpg'),
            imageContainer('grow/img2.jpg'),
            imageContainer('grow/img3.jpg'),
            imageContainer('grow/img11.jpg'),
            imageContainer('grow/img12.jpg'),
            imageContainer('grow/img4.jpg'),
            imageContainer('grow/img5.jpg'),
            imageContainer('grow/img6.jpg'),
            imageContainer('grow/img7.jpg'),
          ],
        ),
      ),
    );
  }

  Widget imageContainer(String imgPath) {
    return InkWell(
      onTap: () => {selectPlantImage(imgPath)},
      child: Container(
        height: 250.0,
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

  void selectPlantImage(String imgPath) {
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
