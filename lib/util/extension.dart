extension EnumExtension on Enum {
  String getValue() {
    return toString().split(".")[1];
  }
}
