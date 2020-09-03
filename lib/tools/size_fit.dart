import 'package:flutter/material.dart';

class HYSizeFit {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double rpx;
  static double px;

  static void initialize(BuildContext context, {double standardWidth = 750}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    rpx = screenWidth / standardWidth;
    px = screenWidth / standardWidth * 2;
  }

  // 按照像素来设置
  static double setPx(double size) {
    return HYSizeFit.rpx * size * 2;
  }

  // 按照rxp来设置
  static double setRpx(double size) {
    return HYSizeFit.rpx * size;
  }
}

extension IntFit on int {
  double get px {
    return HYSizeFit.setPx(this.toDouble());
  }

  double get rpx {
    return HYSizeFit.setRpx(this.toDouble());
  }
}

extension DoubleFit on double {
  double get px {
    return HYSizeFit.setPx(this);
  }

  double get rpx {
    return HYSizeFit.setRpx(this);
  }
}
