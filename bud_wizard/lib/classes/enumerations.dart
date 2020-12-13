import 'package:json_annotation/json_annotation.dart';

//region UI Enums

enum Screen {
  Home,
  Messages,
  Grows,
  Social,
  KnowledgeBase,
  Settings,
  Login,
}

enum DankButtonType {
  Flat,
  Outline,
}

enum DankShieldStatus {
  Success,
  Warning,
  Error,
}

//endregion
//#region HTTP Enums

enum HttpMethod {
  GET,
  PUT,
  POST,
  DELETE,
}

//#endregion
//#region Sensitive Editable Text Field Enums

enum SensitiveFieldType {
  UniqueId,
  Email,
}
enum ValidationType {
  TextBasedValidation,
  ButtonBasedValidation,
}

//#endregion
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
