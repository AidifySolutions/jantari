import 'package:flutter/material.dart';
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double _screenWidth;
  static late double _screenHeight;
  static late bool _isMobileLayout;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _isMobileLayout = _mediaQueryData.size.shortestSide < 600;
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
  }

  static double resizeWidth(double percent){
    if(_isMobileLayout){
      return (_screenWidth/100)*percent;
    }else{
      return (_screenWidth/150)*percent;
    }
  }

  static double resizeHeight(double percent){
    if(_isMobileLayout){
      return (_screenWidth/100)*percent;
    }else{
      return (_screenWidth/150)*percent;
    }
  }

  static double resizeFont(doublePercent){
    if(_isMobileLayout){
      return doublePercent * (_screenWidth/3) /100;
    }else{
      return doublePercent * (_screenWidth/3) /200;
    }
  }

}

// import 'package:flutter/material.dart';
//
// class SizeConfig {
//   static late MediaQueryData _mediaQueryData;
//   static late double _screenWidth;
//   static late double _screenHeight;
//
//   void init(BuildContext context) {
//     _mediaQueryData = MediaQuery.of(context);
//     _screenWidth = _mediaQueryData.size.width;
//     _screenHeight = _mediaQueryData.size.height;
//   }
//
//   static double resizeWidth(double percent){
//     return (_screenWidth/100)*percent;
//   }
//
//   static double resizeHeight(double percent){
//     return (_screenWidth/100)*percent;
//   }
//
//   static double resizeFont(doublePercent){
//     return doublePercent * (_screenWidth/3) /100;
//   }
//
// }