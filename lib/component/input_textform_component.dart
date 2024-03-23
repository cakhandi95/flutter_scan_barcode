import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/color_styles.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/font_styles.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/widget_styles.dart';
import 'package:responsive_framework/responsive_framework.dart';

class InputTextFormComponent extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String label;
  final String hint;
  final String? Function(String)? validator;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final VoidCallback? suffixIconPressed;
  final VoidCallback? onPressed;
  final Function? onSaved;
  final TextInputType keyboardType;
  final bool isDisabled;
  final int? maxLength;
  final Widget? iconInput;
  final bool readOnly;
  final bool? enableInteractiveSelection;

  const InputTextFormComponent({
    super.key,
    this.controller,
    this.obscureText = false,
    this.label = '',
    this.hint = '',
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.suffixIconPressed,
    this.onPressed,
    this.onSaved,
    this.keyboardType = TextInputType.text,
    this.isDisabled = false,
    this.readOnly = false,
    this.enableInteractiveSelection = false,
    this.maxLength,
    this.iconInput,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveBreakpoints.of(context).isMobile ? 50.0 : 70.0,
      child: TextFormField(
        readOnly: readOnly,
        onTap: onPressed,
        maxLength: maxLength,
        maxLines: obscureText ? 1 : null,
        enabled: !isDisabled,
        enableInteractiveSelection: enableInteractiveSelection,
        onSaved: onSaved == null ? null : (value) => onSaved!(value),
        controller: controller,
        style: ResponsiveBreakpoints.of(context).isMobile
            ? kBodyMedium14
            : kBodyMedium16,
        obscureText: obscureText,
        inputFormatters: keyboardType == TextInputType.number
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp("[A-Za-z0-9~`!@#\$%^&*()-_=+:;\"'<,>.?/\\|{} ]*"))
              ],
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadiusCorner),
            borderSide: const BorderSide(color: kPrimary400, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadiusCorner),
            borderSide: const BorderSide(color: kGrayScale100, width: 1.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadiusCorner),
            borderSide: const BorderSide(color: kGrayScale100, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadiusCorner),
            borderSide: const BorderSide(color: kDangerRed, width: 2.0),
          ),
          suffix: suffix,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: suffixIconPressed,
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }
}
