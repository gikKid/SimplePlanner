// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class SizeConfig {
  MediaQueryData mediaQueryData;

  SizeConfig({required this.mediaQueryData});

  double screenWidth() {
    return mediaQueryData.size.width;
  }

  double screenHeight() {
    return mediaQueryData.size.height;
  }

  // double defaultSize() {

  // }

  Orientation orientation() {
    return mediaQueryData.orientation;
  }
}

double getProportionateScreenHeight(BuildContext context, double inputHeight) {
  final sizeConfig = SizeConfig(mediaQueryData: MediaQuery.of(context));
  double screenHeight = sizeConfig.screenHeight();
  return (inputHeight / 812.0) *
      screenHeight; // 812 is the layout height that designer use
}

double getProportionateScreenWidth(BuildContext context, double inputWidth) {
final sizeConfig = SizeConfig(mediaQueryData: MediaQuery.of(context));
  double screenWidth = sizeConfig.screenWidth();
  return (inputWidth / 375.0) *
      screenWidth; //375 is the layout width that designer use
}
