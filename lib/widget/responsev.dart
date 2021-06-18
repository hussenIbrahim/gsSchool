import 'dart:developer';

import 'package:flutter/material.dart';

class Responsive {
  static Responsive _instance;
  static const Size defaultSize = Size(1080, 1920);

  Size uiSize = defaultSize;
  bool allowFontScaling = false;

  static double _pixelRatio;
  static double _screenWidth;
  static double _screenHeight;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  static double _textScaleFactor;

  Responsive._();

  factory Responsive() {
    assert(
      _instance != null,
      '\nEnsure to initialize Responsive before accessing it.\nPlease execute the init method : Responsive.init()',
    );
    return _instance;
  }

  static void init(
    BuildContext context, {
    Size designSize = defaultSize,
    bool allowFontScaling = false,
  }) {
    _instance ??= Responsive._();
    _instance
      ..uiSize = designSize
      ..allowFontScaling = allowFontScaling;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.shortestSide;
    _screenHeight = mediaQuery.size.longestSide;
    _pixelRatio = _screenWidth / _screenHeight;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  /// The number of font pixels for each logical pixel.
  double get textScaleFactor => _textScaleFactor;

  /// The size of the media in logical pixels (e.g, the size of the screen).
  double get pixelRatio => _pixelRatio;

  /// The horizontal extent of this size.
  double get screenWidth => _screenWidth;

  ///The vertical extent of this size. dp
  double get screenHeight => _screenHeight;

  /// The vertical extent of this size. px
  double get screenWidthPx => _screenWidth * _pixelRatio;

  /// The vertical extent of this size. px
  double get screenHeightPx => _screenHeight * _pixelRatio;

  /// The offset from the top
  double get statusBarHeight => _statusBarHeight;

  /// The offset from the bottom.
  double get bottomBarHeight => _bottomBarHeight;

  /// The ratio of the actual dp to the design draft px
  double get scaleWidth => _screenWidth / uiSize.width;

  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => scaleWidth;

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  double setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  double setHeight(num height) => height * scaleHeight;

  ///Font size adaptation method
  ///- [fontSize] The size of the font on the UI design, in px.
  ///- [allowFontScaling]
  double setSp(num fontSize, {bool allowFontScalingSelf}) {
    double size = allowFontScalingSelf == null
        ? (allowFontScaling
            ? (fontSize * scaleText)
            : ((fontSize * scaleText) / _textScaleFactor))
        : (allowFontScalingSelf
            ? (fontSize * scaleText)
            : ((fontSize * scaleText) / _textScaleFactor));
    double ratio = _screenWidth / _screenHeight;
    log(ratio.toString());
    // if ((ratio >= 0.49) && (ratio < 1.5)) {
    //   return size * 0.7;
    // } else {
    return size;
    // }
  }
}
