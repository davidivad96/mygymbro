import 'package:get/get.dart';

class Dimensions {
  static double height = Get.context!.height;
  static double width = Get.context!.width;

  // paddings
  static double screenPaddingVertical = height / 42.2;
  static double screenPaddingHorizontal = width / 15.6;
  static double cardPadding = height / 56.2;
  static double modalPaddingVertical = height / 18.75;
  static double modalPaddingHorizontal = width / 11.14;

  // margins
  static double screenTitleMarginBottom = height / 56.26;
  static double searchInputMarginBottom = height / 84.4;

  // heights
  static double cardMinHeight = height / 7.0;
}
