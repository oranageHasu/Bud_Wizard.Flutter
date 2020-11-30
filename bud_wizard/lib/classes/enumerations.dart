//region UI Enums

import 'package:json_annotation/json_annotation.dart';

enum Screen { messages, grows, social, knowledgeBase, settings, login }

//endregion
//region Plant Enums

enum Gender { unknown, male, female, hermaphrodite }

enum GeneticType {
  sativaDominant,
  indicaDominant,
  sativaDominantHybrid,
  indicaDominatHybrid,
  unknownHybrid
}

enum GrowState { germination, vegatative, flowering, drying, curing }

//endregion
//region Grow Enums

enum GrowSetting {
  @JsonValue(0)
  outdoor,
  @JsonValue(1)
  indoor
}

enum LightStyle { sun, LED, fluorescent, HID_HM, HID_HPS, LEC }

enum UnitType { grams, milliliters }

//endregion
