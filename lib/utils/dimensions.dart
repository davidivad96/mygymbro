import 'package:get/get.dart';

class Dimensions {
  static double height = Get.context!.height;
  static double width = Get.context!.width;

  // padding
  static double screenPaddingVertical = height / 42.2;
  static double screenPaddingHorizontal = width / 15.6;

  // margin
  static double screenTitleMarginBottom = height / 56.26;
  static double searchInputMarginBottom = height / 84.4;
}
