// ignore_for_file: deprecated_member_use

import 'package:frontend_nexus/entry_point/application/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend_nexus/entry_point/application/config/app_colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    scaffoldBackgroundColor: AppColors.whiteColor,
    dividerColor: AppColors.divider,
    hintColor: AppColors.hintColor,
    highlightColor: AppColors.greyColor,
    primarySwatch: AppColors.primaryColor,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor.shade500,
      onPrimary: AppColors.whiteColor,
      secondary: AppColors.secondaryColor.shade500,
      onSecondary: AppColors.whiteColor,
      surface: AppColors.whiteColor,
      onSurface: AppColors.blackColor,
      background: AppColors.whiteColor,
      onBackground: AppColors.blackColor,
      error: AppColors.errorColor,
      onError: AppColors.whiteColor,
      outline: AppColors.greyColor,
      shadow: Colors.black26,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thickness: WidgetStateProperty.all(7),
      radius: const Radius.circular(10),
      interactive: true,
      trackVisibility: WidgetStateProperty.all(true),
      thumbVisibility: WidgetStateProperty.all(true),
      trackBorderColor: WidgetStateProperty.all(Colors.grey.shade300),
      thumbColor: WidgetStateProperty.all(AppColors.primaryColor),
      trackColor: WidgetStateProperty.all(Colors.grey.shade300),
    ),
    cardTheme: CardThemeData(
      color: AppColors.whiteColor,
      surfaceTintColor: AppColors.whiteColor,
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFFEEEEEE)),
    iconTheme: const IconThemeData(
        ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryColor;
        }
        return AppColors.primaryColor;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.whiteColor;
        }
        return AppColors.whiteColor;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryColor;
        }
        return AppColors.primaryColor;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return Colors.white;
        }),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return Colors.white;
        }),
        side: const BorderSide(color: AppColors.primaryColor, width: 2)),
    dialogTheme: DialogThemeData(
        contentTextStyle: GoogleFonts.montserratTextTheme().bodyLarge!.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
        titleTextStyle: GoogleFonts.montserratTextTheme().bodyLarge!.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey.shade200),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyLarge: GoogleFonts.poppinsTextTheme().bodyLarge!.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.normal,
          ),
      headlineMedium: GoogleFonts.poppinsTextTheme().headlineMedium!.copyWith(
            color: AppColors.blackColor,
          ),
      titleMedium: GoogleFonts.poppinsTextTheme().titleMedium!.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.normal,
          ),
      titleLarge: GoogleFonts.poppinsTextTheme().titleLarge!.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.normal,
          ),
      bodySmall: GoogleFonts.poppinsTextTheme().bodySmall!.copyWith(
            color: AppColors.blackColor,
            fontWeight: FontWeight.normal,
          ),
      bodyMedium: GoogleFonts.poppinsTextTheme().bodyMedium!.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.normal,
          ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.greyColor;
          }
          return AppColors.defaultColor;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryColor.shade50;
          }
          return Colors.transparent;
        }),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          );
        }),
        padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
          return const EdgeInsets.all(
            AppStyles.paddingM,
          );
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.greyColor;
          }
          return AppColors.whiteColor;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryColor.shade50;
          }
          return Colors.transparent;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          Color _borderColor;
          double _width = 2.0;

          if (states.contains(WidgetState.disabled)) {
            _borderColor = Colors.transparent;
            _width = 0.0;
          } else if (states.contains(WidgetState.pressed)) {
            _borderColor = AppColors.primaryColor.shade300;
          } else {
            _borderColor = AppColors.primaryColor;
          }

          return BorderSide(color: _borderColor, width: _width);
        }),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          );
        }),
        padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
          return const EdgeInsets.only(
            top: AppStyles.paddingL,
            bottom: AppStyles.paddingL,
            left: AppStyles.paddingM,
            right: AppStyles.paddingM,
          );
        }),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          );
        }),
        padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
          return const EdgeInsets.all(
            AppStyles.paddingM,
          );
        }),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(letterSpacing: 0),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.greyColor,
          style: BorderStyle.solid,
          width: AppStyles.spaceXS,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.greyColor,
          width: AppStyles.spaceXS,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primaryColor.shade100,
          width: AppStyles.spaceXS,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.secondaryColor.shade300,
          style: BorderStyle.solid,
          width: AppStyles.spaceXS,
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    scaffoldBackgroundColor: AppColors.DarkColor2,
    dividerColor: AppColors.divider,
    hintColor: AppColors.hintColor,
    highlightColor: AppColors.greyColor,
    primarySwatch: AppColors.secondaryColor,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor.shade500,
      onPrimary: AppColors.whiteColor,
      secondary: AppColors.secondaryColor.shade500,
      onSecondary: AppColors.whiteColor,
      surface: AppColors.DarkColor1,
      onSurface: Colors.white70,
      background: AppColors.DarkColor2,
      onBackground: Colors.white70,
      error: AppColors.errorColor,
      onError: AppColors.whiteColor,
      outline: Colors.white30,
      shadow: Colors.black54,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thickness: WidgetStateProperty.all(7),
      radius: const Radius.circular(10),
      interactive: true,
      trackBorderColor: WidgetStateProperty.all(Colors.white.withOpacity(0.3)),
      thumbColor:
          WidgetStateProperty.all(AppColors.colorOrangeligth.withOpacity(0.7)),
      trackColor: WidgetStateProperty.all(Colors.white.withOpacity(0.3)),
    ),
    cardTheme: const CardThemeData(
      color: AppColors.whiteColor,
      surfaceTintColor: AppColors.DarkColor1,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.colorOrangeligth;
        }
        return Colors.white70;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.DarkColor1;
        }
        return AppColors.DarkColor1;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white70;
        }
        return Colors.white70;
      }),
    ),
    dividerTheme: const DividerThemeData(color: Colors.white30),
    checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.DarkColor1;
          }
          return Colors.white;
        }),
        side: const BorderSide(color: AppColors.DarkColor1, width: 2)),
    dialogTheme: const DialogThemeData(
        contentTextStyle: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          fontSize: 24, // Ajusta el tamaño si es necesario
        ),
        titleTextStyle: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          fontSize: 24, // Ajusta el tamaño si es necesario
        ),
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.DarkColor1,
        shadowColor: Color(0xFFEEEEEE)), // Equivalente a Colors.grey.shade200
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineLarge: GoogleFonts.poppinsTextTheme().headlineLarge!.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.normal,
          ),
      headlineMedium: GoogleFonts.poppinsTextTheme().headlineMedium!.copyWith(
            color: AppColors.blackColor,
          ),
      titleSmall: GoogleFonts.poppinsTextTheme().titleMedium!.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.normal,
          ),
      titleMedium: GoogleFonts.poppinsTextTheme().titleMedium!.copyWith(
            color: AppColors.blackColor,
            fontWeight: FontWeight.normal,
          ),
      titleLarge: GoogleFonts.poppinsTextTheme().titleLarge!.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.normal,
          ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.greyColor;
          }
          return AppColors.defaultColor;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryColor.shade50;
          }
          return Colors.transparent;
        }),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          );
        }),
        padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
          return const EdgeInsets.all(
            AppStyles.paddingM,
          );
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.greyColor;
          }
          return AppColors.whiteColor;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryColor.shade50;
          }
          return Colors.transparent;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          Color _borderColor;
          double _width = 2.0;

          if (states.contains(WidgetState.disabled)) {
            _borderColor = Colors.transparent;
            _width = 0.0;
          } else if (states.contains(WidgetState.pressed)) {
            _borderColor = AppColors.primaryColor.shade300;
          } else {
            _borderColor = AppColors.primaryColor;
          }

          return BorderSide(color: _borderColor, width: _width);
        }),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          );
        }),
        padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
          return const EdgeInsets.only(
            top: AppStyles.paddingL,
            bottom: AppStyles.paddingL,
            left: AppStyles.paddingM,
            right: AppStyles.paddingM,
          );
        }),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.resolveWith<TextStyle>((_) {
          return const TextStyle(color: Colors.white70);
        }),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          );
        }),
        padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
          return const EdgeInsets.all(
            AppStyles.paddingM,
          );
        }),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(letterSpacing: 0),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.greyColor,
          style: BorderStyle.solid,
          width: AppStyles.spaceXS,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.greyColor,
          width: AppStyles.spaceXS,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primaryColor.shade100,
          width: AppStyles.spaceXS,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.secondaryColor.shade300,
          style: BorderStyle.solid,
          width: AppStyles.spaceXS,
        ),
      ),
    ),
  );
}
