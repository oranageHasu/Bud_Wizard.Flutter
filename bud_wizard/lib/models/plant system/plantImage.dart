import 'package:flutter/foundation.dart';

class PlantImage {
  final String base64Image;

  PlantImage({
    @required String base64Image,
  }) : this.base64Image = base64Image;

  factory PlantImage.fromJson(Map<String, dynamic> json) {
    PlantImage retval = PlantImage(
      base64Image: json['base64Image'],
    );

    return retval;
  }
}
