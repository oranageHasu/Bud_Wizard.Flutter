import 'package:flutter/foundation.dart';
import 'package:bud_wizard/classes/enumerations.dart';

class GrowLight {
  String brand;
  String model;
  LightStyle style;
  GrowState usage;

  GrowLight({
    @required String brand,
    @required String model,
    @required LightStyle style,
    GrowState usage = GrowState.Vegetative,
  })  : this.brand = brand,
        this.model = model,
        this.style = style,
        this.usage = usage;

  factory GrowLight.fromJson(Map<String, dynamic> json) {
    return GrowLight(
      brand: json['brand'],
      model: json['model'],
      style:
          LightStyle.values.firstWhere((e) => e.index == json['style'] as int),
      usage:
          GrowState.values.firstWhere((e) => e.index == json['usage'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'model': model,
      'style': style.index.toString(),
      'usage': style.index.toString(),
    };
  }
}
