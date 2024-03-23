import 'package:flutter/material.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/color_styles.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'font_styles.dart';

///
/// Created by Handy on 02/06/23
/// Macbook Air M2 - 2022
/// it.handy@borwita.co.id / it.handy
///
enum ButtonSize { small, regular, large }

const double kButtonSmall = 36.0;
const double kButtonRegular = 44.0;
const double kButtonLarge = 52.0;
const double kRadiusCorner = 8.0;

const double kButtonTabletSmall = 40.0;
const double kButtonTabletRegular = 48.0;
const double kButtonTabletLarge = 56.0;

class ButtonPrimary extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final bool isDisabled;
  final bool hasIcon;
  final double width;
  final Color colorText;
  final Color colorButton;
  final ButtonSize buttonSize;
  final String? fileIcon;
  final IconData? iconData;
  final Color colorIcon;
  final TextAlign textAlign;

  const ButtonPrimary(
    this.title, {
    super.key,
    required this.onPressed,
    this.width = 0,
    required this.buttonSize,
    required this.colorText,
    required this.colorButton,
    this.isOutlined = false,
    this.hasIcon = false,
    this.isDisabled = false,
    this.colorIcon = Colors.white,
    this.fileIcon,
    this.iconData,
    this.textAlign = TextAlign.center,
  });

  TextStyle buttonTextStyleMobile() {
    switch (buttonSize) {
      case ButtonSize.small:
        return kBodyMedium12;

      case ButtonSize.regular:
        return kBodyMedium14;

      case ButtonSize.large:
        return kBodyMedium16;
    }
  }

  double buttonHeightMobile() {
    switch (buttonSize) {
      case ButtonSize.small:
        return kButtonSmall;

      case ButtonSize.regular:
        return kButtonRegular;

      case ButtonSize.large:
        return kButtonLarge;
    }
  }

  TextStyle buttonTextStyleTablet() {
    switch (buttonSize) {
      case ButtonSize.small:
        return kBodyMedium14;

      case ButtonSize.regular:
        return kBodyMedium16;

      case ButtonSize.large:
        return kBodyMedium18;
    }
  }

  double buttonHeightTablet() {
    switch (buttonSize) {
      case ButtonSize.small:
        return kButtonTabletSmall;

      case ButtonSize.regular:
        return kButtonTabletRegular;

      case ButtonSize.large:
        return kButtonTabletLarge;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isMobile) {
      if (hasIcon) {
        return SizedBox(
          width: width == 0 ? null : width,
          height: buttonHeightMobile(),
          child: TextButton.icon(
              onPressed: isDisabled ? null : onPressed,
              icon: iconData == null
                  ? Image.asset(
                      fileIcon!,
                      color: colorIcon,
                      width: buttonHeightMobile(),
                      height: buttonHeightMobile(),
                      fit: BoxFit.contain,
                    )
                  : Icon(
                      iconData,
                      color: colorIcon,
                      size: buttonHeightMobile() / 2,
                    ),
              label: Text(
                title,
                textAlign: textAlign,
                style: buttonTextStyleMobile().copyWith(color: colorText),
              ),
              style: isOutlined
                  ? outlinedButtonStyle(colorButton)
                  : buttonStyle(colorButton)),
        );
      } else {
        return Container(
          width: width == 0 ? null : width,
          height: buttonHeightMobile(),
          color: Colors.transparent,
          child: TextButton(
            onPressed: isDisabled ? null : onPressed,
            style: isOutlined
                ? outlinedButtonStyle(colorButton)
                : buttonStyle(colorButton),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                textAlign: textAlign,
                style: buttonTextStyleMobile().copyWith(color: colorText),
              ),
            ),
          ),
        );
      }
    } else {
      if (hasIcon) {
        return SizedBox(
          width: width == 0 ? null : width,
          height: buttonHeightTablet(),
          child: TextButton.icon(
            onPressed: isDisabled ? null : onPressed,
            icon: iconData == null
                ? Image.asset(
                    fileIcon!,
                    color: colorIcon,
                    width: buttonHeightTablet(),
                    height: buttonHeightTablet(),
                    fit: BoxFit.contain,
                  )
                : Icon(
                    iconData,
                    color: colorIcon,
                    size: buttonHeightTablet() / 2,
                  ),
            label: Text(
              title,
              textAlign: textAlign,
              style: buttonTextStyleTablet().copyWith(color: colorText),
            ),
            style: isOutlined
                ? outlinedButtonStyle(colorButton)
                : buttonStyle(colorButton),
          ),
        );
      } else {
        return Container(
          width: width == 0 ? null : width,
          height: buttonHeightTablet(),
          color: Colors.transparent,
          child: TextButton(
            onPressed: isDisabled ? null : onPressed,
            style: isOutlined
                ? outlinedButtonStyle(colorButton)
                : buttonStyle(colorButton),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                textAlign: textAlign,
                style: buttonTextStyleTablet().copyWith(color: colorText),
              ),
            ),
          ),
        );
      }
    }
  }
}

class MediumOutlineButton extends StatelessWidget {
  final String title;
  final double width;
  final VoidCallback? onPressed;

  const MediumOutlineButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 40,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: kBlueDark,
              width: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            )),
        child: Text(
          title,
          style: kBodyBold14.copyWith(color: kBlueDark),
        ),
      ),
    );
  }
}

class MediumButton extends StatelessWidget {
  final String title;
  final double width;
  final VoidCallback? onPressed;

  const MediumButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 40,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: kBlueDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          title,
          style: kBodyMedium12.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}


ButtonStyle outlinedButtonStyle(Color colorButton) => ButtonStyle(
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusCorner),
        ),
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      foregroundColor: MaterialStateProperty.resolveWith(<Color>(states) {
        return kWhite;
      }),
      side: MaterialStateProperty.resolveWith<BorderSide?>((states) {
        return BorderSide(
          color: colorButton,
          width: 2,
        );
      }),
      elevation: MaterialStateProperty.resolveWith((states) => 0.0),
      shadowColor:
          MaterialStateProperty.resolveWith((states) => Colors.transparent),
      backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return kWhite;
        }
        if (states.contains(MaterialState.focused)) {
          return kWhite;
        }
        if (states.contains(MaterialState.hovered)) {
          return kWhite;
        }
        if (states.contains(MaterialState.disabled)) {
          return kLineStroke;
        }
        return kWhite;
      }),
    );

ButtonStyle buttonStyle(Color colorButton) => ButtonStyle(
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusCorner),
        ),
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      foregroundColor: MaterialStateProperty.resolveWith(<Color>(states) {
        return colorButton;
      }),
      side: MaterialStateProperty.resolveWith<BorderSide?>((states) {
        if (states.contains(MaterialState.disabled)) return null;
        return BorderSide(
          color: colorButton,
          width: 1.5,
        );
      }),
      elevation: MaterialStateProperty.resolveWith((states) => 0.0),
      shadowColor:
          MaterialStateProperty.resolveWith((states) => Colors.transparent),
      backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return colorButton;
        }
        if (states.contains(MaterialState.focused)) {
          return colorButton;
        }
        if (states.contains(MaterialState.hovered)) {
          return colorButton;
        }
        if (states.contains(MaterialState.disabled)) {
          return kMutedGray;
        }
        return colorButton;
      }),
    );
