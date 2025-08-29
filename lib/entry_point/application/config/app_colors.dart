import 'package:flutter/material.dart';

class AppColors {
  static const int _primarColorValue = 0xFF003F85;
  static const int _accentColorValue = 0xFF5479FF;
  static const int _secondaryColorValue = 0xFFF57E31;
  static const blueColor = Color(0xff409CFF);

  static Color? _customPrimaryColor;
  static Color? _customSecondaryColor;
  static Color? _customAccentColor;

  static const Map<int, Color> primaryColorCodes = {
    50: Color(0xFFE0E8F0),
    100: Color(0xFFB3C5DA),
    200: Color(0xFF809FC2),
    300: Color(0xFF4D79AA),
    400: Color(0xFF265C97),
    500: Color(_primarColorValue),
    600: Color(0xFF00397D),
    700: Color(0xFF003172),
    800: Color(0xFF002968),
    900: Color(0xFF001B55),
  };

  static const Map<int, Color> accentColorCodes = {
    100: Color(0xFF87A1FF),
    200: Color(_accentColorValue),
    400: Color(0xFF2151FF),
    500: Color(0XFF0346AD),
    700: Color(0xFF083DFF),
    800: Color(0xFF002ed6),
    900: Color(0xFF045AC5),
  };

  static const Map<int, Color> secondaryColorCodes = {
    50: Color(0xFFFEF0E6),
    100: Color(0xFFFCD8C1),
    200: Color(0xFFFABF98),
    300: Color(0xFFF8A56F),
    400: Color(0xFFF79150),
    500: Color(_secondaryColorValue),
    600: Color(0xFFF4762C),
    700: Color(0xFFF26B25),
    800: Color(0xFFF0611F),
    900: Color(0xFFEE4E13),
  };

  static const MaterialColor primaryColor = MaterialColor(_primarColorValue, primaryColorCodes);
  static const MaterialColor primaryColorDark = MaterialColor(_primarColorValue, primaryColorCodes);
  static const MaterialColor accentColor = MaterialColor(_accentColorValue, accentColorCodes);
  static const MaterialColor secondaryColor = MaterialColor(_secondaryColorValue, secondaryColorCodes);
  static const MaterialColor ternaryColor = MaterialColor(0xFFF79150, secondaryColorCodes);

  static Color get primary => _customPrimaryColor ?? primaryColor;
  static Color get accent => _customAccentColor ?? accentColor;
  static Color get secondary => _customSecondaryColor ?? secondaryColor;

  static void setCustomColors({String? primaryColor, String? secondaryColor, String? accentColor}) {
    if (primaryColor != null && primaryColor.isNotEmpty) {
      _customPrimaryColor = Color(int.parse('0xFF${primaryColor.replaceAll('#', '')}'));
    }
    if (secondaryColor != null && secondaryColor.isNotEmpty) {
      _customSecondaryColor = Color(int.parse('0xFF${secondaryColor.replaceAll('#', '')}'));
    }
    if (accentColor != null && accentColor.isNotEmpty) {
      _customAccentColor = Color(int.parse('0xFF${accentColor.replaceAll('#', '')}'));
    }
  }

  static void resetColors() {
    _customPrimaryColor = null;
    _customSecondaryColor = null;
    _customAccentColor = null;
  }

  static const Color hintColor = Color(0xFFBDBDBD);
  static const Color scaffoldBackgroundColor = Color(0xFFFFFFFF);
  static const Color icons = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFBDBDBD);
  static const Color primaryText = Color(0xFF212121);
  static const Color secondaryText = Color(0xFF757575);
  static const Color errorColor = Color(0xFFB00020);
  static const Color infoColor = Color(0xFF2196F3);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color successColor = Color(0xFF2E7D32);
  static const Color normalColor = Color(0xFF2D3243);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color greyColor = Color(0xFFCFD8DC);
  static const Color defaultColor = Color(0xFFF4F5F7);
  static const Color blackColor = Color(0xFF2D3243);
  static Color fillColorFields = divider.withValues(alpha: 0.5);

  static const Color primaryButtonColor = Color(_primarColorValue);
  static const Color primaryButtonTextColor = Color(0xFFFFFFFF);






  static const Color successLightColorClear = Color(0xFF27AE60);
  static const Color successLightColor = Color(0xFF4CAF50);
  static const Color warningLightColor = Color(0xFFFFCC80);

  static const Color mateColor = Colors.white70;
  static const Color platinumColor = Color(0xFFECEEF1);
  static const Color silverColor = Color(0xFFEDF3FA);
  static const Color appbarColor1 = Color(0xFF1457AE);
  static const Color appbarColor2 = Color(0xFF294C8A);
  static const Color DarkColor1 = Color(0xFF002759);
  static const Color DarkColor2 = Color(0xFF001A3D);
  static const Color DarkColor3 = Color(0xFF002d7e);
  static const Color logingradientColor1 = Color(0XFFE8F0F9);
  static const Color logingradientColor2 = Color(0XFFFCF3EB);
  static const Color logingradientColor3 = Color(0XFFF3F7FB);
  static const Color logingradientColor4 = Color(0XFFFCF7F4);
  static const Color colorBorder = Color(0XFFCFD8DC);
  static const Color primaryContrastColor = Color(0xFF045FCB);
  static const Color colorModal = Color(0XFFE5E5EB);
  static const Color colorDark = Color(0XFF343a40);
  static const Color colorDarkDifuminado = Color(0XFF40424e);
  static const Color colorBackGroundDark = Color(0XFF01122C);
  static const Color colorOrangeligth = Color(0XFFffb400);
  static const Color colorOrangeMate = Color(0XFFe1953d);
}
