import 'package:department_web/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintTxt;
  final String? label;
  final String? initValue;
  final Widget? prefexIcon;
  final Widget? suffixIcon;
  final Function? onPressedPrefexIcon;
  final VoidCallback? onPressedSuffixIcon;
  final Function? onChange;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Color? fillColor;
  final bool? obscureText;
  final bool? enable;
  final int? minLines;
  final int? maxLines;
  final double? horizontalPadding;
  final double? verticalPadding;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    this.hintTxt,
    this.label = "",
    this.onPressedPrefexIcon,
    this.keyboardType,
    this.controller,
    this.onChange,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.prefexIcon,
    this.fillColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.enable = true,
    this.onPressedSuffixIcon,
    this.suffixIcon,
    this.initValue = "",
    this.inputFormatters,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        inputFormatters: inputFormatters,
        style: TextStyle(
          color: Theme.of(context).textTheme.labelLarge!.color,
        ),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "please enter valid data";
          }
          return null;
        },
        enabled: enable,
        minLines: minLines,
        maxLines: maxLines,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: (hintTxt ?? ""),
          label: CustomText(
            txt: label,
            fontSize: 14,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
          fillColor: fillColor ?? Theme.of(context).colorScheme.surface,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          hintStyle: TextStyle(
            fontSize: 8,
            overflow: TextOverflow.ellipsis,
          ),
          prefixIcon: prefexIcon,
          suffixIcon: suffixIcon,
        ),
        onChanged: (value) => onChange == null ? () {} : onChange!(value),
        keyboardType: keyboardType,
        obscureText: obscureText!,
      ),
    );
  }
}
