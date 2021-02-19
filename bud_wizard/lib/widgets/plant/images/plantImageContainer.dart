import 'dart:convert';
import 'package:bud_wizard/models/plant%20system/plantImage.dart';
import 'package:bud_wizard/services/api%20services/apiPlantImages.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_guid/flutter_guid.dart';

class PlantImageContainer extends StatefulWidget {
  final String imageName;
  final Guid userId;
  final Guid plantId;
  final int growWeek;

  PlantImageContainer({
    @required String imageName,
    @required Guid userId,
    @required Guid plantId,
    @required int growWeek,
  })  : this.imageName = imageName,
        this.userId = userId,
        this.plantId = plantId,
        this.growWeek = growWeek;

  @override
  _PlantImageContainerState createState() => _PlantImageContainerState();
}

class _PlantImageContainerState extends State<PlantImageContainer> {
  Future<PlantImage> _plantImage;

  @override
  void initState() {
    super.initState();

    _plantImage = getPlantImage(
      userId: widget.userId,
      plantId: widget.plantId,
      growWeek: widget.growWeek,
      fileName: widget.imageName,
    );
  }

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
        child: FutureBuilder<PlantImage>(
          future: _plantImage,
          builder: (context, snapshot) {
            Widget retval = SizedBox.shrink();

            if (snapshot.hasData) {
              retval = Image.memory(
                base64Decode(snapshot.data.base64Image),
                fit: BoxFit.fitWidth,
              );
            }

            return retval;
          },
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
