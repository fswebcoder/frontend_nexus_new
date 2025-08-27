import 'package:flutter/material.dart';

class AppColors {
  static const int _primarColorValue = 0xFF20117A;
  static const int _accentColorValue = 0xFF8B4513;
  static const int _secondaryColorValue = 0xFFCA8313;
  static const blueColor = Color(0xff409CFF);

  static Color? _customPrimaryColor;
  static Color? _customSecondaryColor;
  static Color? _customAccentColor;

  static const Map<int, Color> primaryColorCodes = {
    50: Color(0xFFE8E5F5),
    100: Color(0xFFC6BDEA),
    200: Color(0xFFA093DE),
    300: Color(0xFF7A69D1),
    400: Color(0xFF5E4AC7),
    500: Color(_primarColorValue),
    600: Color(0xFF1C0F70),
    700: Color(0xFF170C65),
    800: Color(0xFF130A5B),
    900: Color(0xFF0B0548),
  };

  static const Map<int, Color> accentColorCodes = {
    100: Color(0xFFD2B48C),
    200: Color(_accentColorValue),
    400: Color(0xFF654321),
    700: Color(0xFF4A2C17),
  };

  static const Map<int, Color> secondaryColorCodes = {
    50: Color(0xFFFBF6E9),
    100: Color(0xFFF5E6BC),
    200: Color(0xFFEDD190),
    300: Color(0xFFE5BC64),
    400: Color(0xFFDDA73B),
    500: Color(_secondaryColorValue),
    600: Color(0xFFB87310),
    700: Color(0xFFA6640E),
    800: Color(0xFF94540C),
    900: Color(0xFF7A4509),
  };

  static const MaterialColor primaryColor = MaterialColor(_primarColorValue, primaryColorCodes);
  static const MaterialColor accentColor = MaterialColor(_accentColorValue, accentColorCodes);
  static const MaterialColor secondaryColor = MaterialColor(_secondaryColorValue, secondaryColorCodes);

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
}