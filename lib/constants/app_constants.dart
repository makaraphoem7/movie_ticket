// Flutter imports:
import 'package:flutter/material.dart';

class AppConstants {
  // Color codes (as hex strings)
  static const String primaryColorCode = "#000000";
  static const String secondaryColorCode = "#FF5252";
  static const String backgroundColorCode = "#EFF4F5";
  static const String blackColorCode = "#000000";
  static const String mainColorCode = "#EF1385";
  static const String darkPurpleColorCode = "#4A017D";
  static const String prupleColorCode = "#601098";
  static const String shadowColorCode = "#00000029";
  static const String whiteColorCode = "#FFFFFF";
  static const String darkGreyColorCode = "#707070";
  static const String greenColorCode = "#16950D";
  static const String silverColorCode = "#EBEBEB";
  static const String secondColorCode = "#EF13851A";
  static const String secondColorWhiteCode = "#FAFAFAF0";
  static const String redColorCode = "#E11F1F";
  static const String greyColorCode = "#9E9E9E";
  static const String blueColorCode = "#2196F3";
  static const String lightPinkColorCode = "#F4A017D";

  // Fonts
  static const String fontName = "Inter";
  static const String fontKH = 'Siemreap';
  static const String fontNameBold = "Inter-Bold";
  static const String fontNameRegular = "Inter-Regular";

  // Font sizes
  static const double fontSizeExtraSmall = 10.0;
  static const double fontSizeSmall = 12.0;
  static const double fontSizeDefault = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeExtraLarge = 18.0;
  static const double fontSizeOverLarge = 22.0;
  static const double fontSizeOverLarge20 = 20.0;

  // Padding
  static const double extraSmallPadding = 5.0;
  static const double mediumPadding = 7.0;
  static const double smallPadding = 12.0;
  static const double smallPadding10 = 10.0;
  static const double kDefaultPadding = 15.0;
  static const double kDefaultPadding18 = 18.0;
  static const double kDefaultPadding20 = 20.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 30.0;
  static const double extraLargePadding40 = 40.0;

  // Radius
  static const double kDefaultRadius = 12.0;
  static const double btnRadius = 28.0;

  // Button sizes
  static const double btnSize = 50.0;
  static const double btnSizeSmall = 45.0;
  static const double btnSizeSmall40 = 40.0;
  static const double btnSizeLarge = 60.0;

  // Gaps (spacers)
  static const gapW5 = SizedBox(width: 5);
  static const gapH5 = SizedBox(height: 5);
  static const gapH10 = SizedBox(height: 10);
  static const gapW10 = SizedBox(width: 10);
  static const gapW20 = SizedBox(width: 20);
  static const gapW40 = SizedBox(width: 40);
  static const gapH40 = SizedBox(height: 40);
  static const gapH15 = SizedBox(height: 15);
  static const gapH20 = SizedBox(height: 20);

  /// Convert a hex color string (e.g., "#FFFFFF") to a Flutter [Color].
  static Color hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF$hex"; // Add alpha value if missing (fully opaque).
    }
    return Color(int.parse(hex, radix: 16));
  }

  // Pre-defined Colors for easier use
  static final Color primaryColor = hexToColor(primaryColorCode);
  static final Color secondaryColor = hexToColor(secondaryColorCode);
  static final Color backgroundColor = hexToColor(backgroundColorCode);
  static final Color blackColor = hexToColor(blackColorCode);
  static final Color mainColor = hexToColor(mainColorCode);
  static final Color darkPurpleColor = hexToColor(darkPurpleColorCode);
  static final Color purpleColor = hexToColor(prupleColorCode);
  static final Color shadowColor = hexToColor(shadowColorCode);
  static final Color whiteColor = hexToColor(whiteColorCode);
  static final Color darkGreyColor = hexToColor(darkGreyColorCode);
  static final Color greenColor = hexToColor(greenColorCode);
  static final Color silverColor = hexToColor(silverColorCode);
  static final Color secondColor = hexToColor(secondColorCode);
  static final Color secondColorWhite = hexToColor(secondColorWhiteCode);
  static final Color redColor = hexToColor(redColorCode);
  static final Color greyColor = hexToColor(greyColorCode);
  static final Color blueColor = hexToColor(blueColorCode);
  static final Color lightPinkColor = hexToColor(lightPinkColorCode);

  /// Get the screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get the screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Check if the keyboard is open
  static bool isKeyOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0;
  }
}
