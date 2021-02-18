import 'package:flutter/foundation.dart';

class PlantImageMetadata {
  final String imageName;

  PlantImageMetadata({
    @required String imageName,
  }) : this.imageName = imageName;

  factory PlantImageMetadata.fromJson(Map<String, dynamic> json) {
    PlantImageMetadata retval = PlantImageMetadata(
      imageName: json['imageName'],
    );

    return retval;
  }
}
