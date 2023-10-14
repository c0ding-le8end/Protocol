import 'package:flutter/material.dart';

class ThemeHelper {
  // static Color primaryColor = Color(0xff6758C0);
  static Color primaryColor = Colors.deepPurple;
  // static Color accentColor = Color(0xff20aebe);
  static Color accentColor = Color(0xff008080);
  static Color shadowColor = Color(0xffa2a6af);
static Color primaryText=Color(0xff000000);
  static ThemeData getThemeData() {
    return ThemeData(
      fontFamily: 'Baloo',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,primary: primaryColor),
      textTheme: TextTheme(
          headline3: TextStyle(
            color: Colors.deepPurple,
            fontFamily: 'Baloo',
          ),
          headline4: TextStyle(
            color: primaryColor,
            fontFamily: 'Baloo',
            fontWeight: FontWeight.bold
          ),
      headline5: TextStyle(
          color: primaryText,
          fontFamily: 'Baloo',
          fontWeight: FontWeight.w500,
        fontSize: 20
      ),),
    );
  }

  static BoxDecoration fullScreenBgBoxDecoration(
      {String backgroundAssetImage = "assets/images/Common.bg.png",BuildContext? context}) {

    return BoxDecoration(
      image: DecorationImage(image: AssetImage(backgroundAssetImage), fit: BoxFit.cover),
    );
  }

  static roundBoxDeco({Color color = Colors.white, double radius = 15}) {
    return BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
