import 'package:flutter/material.dart';

import '../typography/dine_in_text_styles.dart';

class DineInTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: Colors.orange,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: Colors.orange,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: DineInTextStyles.displayLarge,
      displayMedium: DineInTextStyles.displayMedium,
      displaySmall: DineInTextStyles.displaySmall,
      headlineLarge: DineInTextStyles.headlineLarge,
      headlineMedium: DineInTextStyles.headlineMedium,
      headlineSmall: DineInTextStyles.headlineSmall,
      titleLarge: DineInTextStyles.titleLarge,
      titleMedium: DineInTextStyles.titleMedium,
      titleSmall: DineInTextStyles.titleSmall,
      bodyLarge: DineInTextStyles.bodyLargeBold,
      bodyMedium: DineInTextStyles.bodyLargeMedium,
      bodySmall: DineInTextStyles.bodyLargeRegular,
      labelLarge: DineInTextStyles.labelLarge,
      labelMedium: DineInTextStyles.labelMedium,
      labelSmall: DineInTextStyles.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
    );
  }
}
