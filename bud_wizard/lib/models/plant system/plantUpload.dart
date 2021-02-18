import 'package:flutter/foundation.dart';
import 'package:flutter_guid/flutter_guid.dart';

class PlantUpload {
  final Guid plantId;
  final Guid userId;
  List<String> images;
  int growWeek;

  PlantUpload({
    @required Guid plantId,
    @required Guid userId,
    @required List<String> images,
    @required int growWeek,
  })  : this.plantId = plantId,
        this.userId = userId,
        this.images = images,
        this.growWeek = growWeek;

  Map<String, dynamic> toJson() {
    return {
      'plantId': plantId.toString(),
      'userId': userId.toString(),
      'images': images,
      'growWeek': growWeek,
    };
  }
}
