import 'package:json_annotation/json_annotation.dart';

//#region User Roles

enum UserRole {
  Developer,
  Admin,
  Support,
  ReadOnly,
}

//#endregion
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

enum DankFlatButtonType {
  RoundedRectangle,
  Stadium,
}

enum DankShieldStatus {
  Success,
  Warning,
  Error,
}

enum GrowOperation {
  AddGrow,
  EditGrows,
  ReadOnlyGrows,
}

enum PlantOperation {
  AddPlant,
  Journal,
  Questions,
  Statistics,
}

enum ChartType {
  BudYieldProjection,
  WateringFrequency,
  HeightOverTime,
  MacroNutrientsBreakdown,
  NutrientTotalUsage,
  NutrientsOverTime,
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

enum Gender {
  Unknown,
  Male,
  Female,
  Hermaphrodite,
}

enum GeneticType {
  SativaDominant,
  IndicaDominant,
  SativaDominantHybrid,
  IndicaDominatHybrid,
  UnknownHybrid,
}

enum GrowState {
  @JsonValue(-1)
  NotApplicable,
  @JsonValue(0)
  Germination,
  @JsonValue(1)
  Vegetative,
  @JsonValue(2)
  Flowering,
  @JsonValue(3)
  Drying,
  @JsonValue(4)
  Curing,
}

//endregion
//region Grow Enums

enum GrowSetting {
  @JsonValue(0)
  Outdoor,
  @JsonValue(1)
  Indoor
}

enum LightStyle {
  Sun,
  LED,
  Fluorescent,
  HID_HM,
  HID_HPS,
  LEC,
}

enum UnitType {
  Grams,
  Milliliters,
}

//endregion
