import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:baqal/src/res/app_colors.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  @override
  final Key? key;
  final String? hint;
  final String? label;
  final String? initialValue;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final String? errorText;
  final bool obscureText;
  final bool? isEnabled;
  final Widget? inputDecorationIcon;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? numberInputFormatter;
  final int? maxLength;
  final int? maxLines;
  final Widget? suffix;
  final Widget? prefix;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final TextStyle? style;
  final bool isValidatorRequired;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final BuildContext? context;
  final Color? fillColor;
  final bool autoFocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool? inputFormat;
  final double? borderRadius;
  final double? containerHeight;
  final double? elivation;
  final double? contentPadding;
  final Color? errorBorderColor;
  final Color? enabledBorderColor;
  final double? enabledBorderWidth;

  CustomTextField({
    this.textEditingController,
    this.hint,
    this.label,
    this.containerHeight,
    this.keyboardType = TextInputType.text,
    this.errorText = 'Please enter some text',
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.obscureText = false,
    this.inputFormatters,
    this.maxLength,
    this.maxLines = 1,
    this.hintStyle,
    this.labelStyle,
    this.initialValue,
    this.isValidatorRequired = true,
    this.focusNode,
    this.inputDecorationIcon,
    this.nextFocusNode,
    this.context,
    this.textInputAction,
    this.autoFocus = false,
    this.key,
    this.onSubmitted,
    this.inputFormat = true,
    this.numberInputFormatter = false,
    this.errorStyle,
    this.fillColor,
    this.isEnabled = true,
    this.suffix,
    this.prefix,
    this.style,
    this.borderRadius,
    this.elivation = 0.1,
    this.contentPadding,
    this.enabledBorderColor = Colors.transparent,
    this.errorBorderColor,
    this.onChanged,
    this.enabledBorderWidth,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final languageProvider = getItInstance<LanguageProvider>();

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    if (nextFocus == null) {
      nextFocus.unfocus();
    }
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.containerHeight,
      alignment: Alignment.center,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.disabled,
        maxLengthEnforcement: MaxLengthEnforcement.none,
        enabled: widget.isEnabled,
        key: widget.key,
        autofocus: widget.autoFocus,
        textAlign:
            languageProvider.isEnglish ? TextAlign.left : TextAlign.right,
        showCursor: true,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        controller: widget.textEditingController,
        style: widget.style,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        textCapitalization: TextCapitalization.words,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        validator: widget.isValidatorRequired
            ? widget.validator ??
                (value) {
                  if (value!.isEmpty) {
                    return widget.errorText;
                  } else {
                    return value;
                  }
                }
            : null,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted ??
            (term) {
              _fieldFocusChange(
                  widget.context!, widget.focusNode!, widget.nextFocusNode!);
            },
        decoration: InputDecoration(
          icon: widget.inputDecorationIcon,
          contentPadding: widget.contentPadding != null
              ? EdgeInsets.symmetric(
                  horizontal: widget.contentPadding!, vertical: 2)
              : null,
          fillColor: widget.fillColor ?? AppColors.colorF6F5F8,
          filled: true,
          hintText: widget.hint,
          suffixIcon: widget.suffix,
          prefixIcon: widget.prefix,
          hintStyle: widget.hint!.length < 30
              ? widget.hintStyle
              : TextStyle(fontSize: 15, color: AppColors.color969696),
          errorStyle: widget.errorStyle ??
              TextStyle(
                  // color: AppColors.errorRed,
                  // fontSize: 0,
                  ),
          border: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: BorderSide(color: AppColors.white, width: 0.0),
          ),
          disabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
          ),
          enabledBorder: OutlineInputBorder(
            //borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: BorderSide(
                color: widget.enabledBorderColor!,
                width: widget.enabledBorderWidth ?? 1.0),
          ),
//          errorBorder: OutlineInputBorder(
//              //borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
//              // borderSide: BorderSide(color: AppColors.errorRed, width: 0.0),
//              ),
        ),
      ),
    );
  }
}
