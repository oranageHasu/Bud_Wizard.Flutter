import 'dart:convert';
import 'package:bud_wizard/widgets/plant/images/plantImageDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantImageContainer extends StatefulWidget {
  final String base64Image;

  PlantImageContainer({
    @required String base64Image,
  }) : this.base64Image = base64Image;

  @override
  _PlantImageSelectorState createState() => _PlantImageSelectorState();
}

class _PlantImageSelectorState extends State<PlantImageContainer> {
  bool _isHovered = false;
  Image img;

  @override
  Widget build(BuildContext context) {
    // Cache the image
    // This is to allow re-rendering of the widget for mouse hover
    if (img == null) {
      img = Image.memory(
        base64Decode(widget.base64Image),
        fit: BoxFit.cover,
      );
    }

    return MouseRegion(
      onEnter: (value) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (value) {
        setState(() {
          _isHovered = false;
        });
      },
      child: InkWell(
        onTap: () => {
          selectPlantImage(
            context,
            widget.base64Image,
          ),
        },
        child: Stack(
          children: [
            Container(
              width: 250.0,
              height: 150.0,
              margin: EdgeInsets.all(2.5),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: img,
            ),
            if (_isHovered)
              Container(
                width: 250.0,
                height: 150.0,
                margin: EdgeInsets.all(2.5),
                color: Colors.black.withOpacity(0.3),
              ),
          ],
        ),
      ),
    );
  }

  void selectPlantImage(BuildContext context, String base64Image) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.7),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: PlantImageDialog(
              base64Image: base64Image,
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
