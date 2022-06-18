import 'package:get/get.dart';

class Dimensions {
  static double height = Get.context!.height;
  static double width = Get.context!.width;

  // paddings
  static double screenPaddingVertical = height / 42.2;
  static double screenPaddingHorizontal = width / 15.6;
  static double workoutCardPadding = height / 56.2;

  // margins
  static double screenTitleMarginBottom = height / 56.26;
  static double searchInputMarginBottom = height / 84.4;

  // heights
  static double workoutCardMinHeight = height / 7.0;
}
