import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:baqal/src/ui/common/dot_progress_indicator.dart';
import 'package:baqal/src/res/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final Color? borderSideColor;
  final double? elevation;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? titleColor;
  final FontWeight? fontWeight;
  final bool hasForwardIcon;
  final Icon? leadingIcon;

  // final bool hasLeadingIcon;
  final bool replaceWithIndicator;
  final bool isEnabled;
  final TextAlign? textAlign;
  final EdgeInsets? margin;

  const CommonButton(
      {Key? key,
      required this.title,
      this.onTap,
      this.textStyle,
      this.buttonColor,
        this.borderSideColor,
      this.titleColor,
      this.elevation,
      this.width,
      this.height,
      this.fontWeight,
      this.fontSize,
      this.textAlign,
      this.leadingIcon,
      this.hasForwardIcon = false,
      // this.hasLeadingIcon = false,
      this.replaceWithIndicator = false,
      this.margin,
      this.isEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonTitleWithLeadingIcon(
        {Icon? leadingIcon, required BuildContext context}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leadingIcon ?? Container(),
          Text(
            title!,
            textAlign: textAlign ?? textAlign,
            style: textStyle ??
                TextStyle(
                    fontSize: fontSize ?? 17,
                    color: titleColor ?? AppColors.white,
                    fontWeight: fontWeight ?? FontWeight.w600),
          ),
          SizedBox(
            width: 1,
          ),
        ],
      );
    }

    return Container(
      height: height ?? 50,
      width: width,
      margin: margin,
      child: MaterialButton(

        disabledColor: AppColors.primaryColor.withOpacity(!isEnabled ? 0.5 : 1),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderSideColor ?? buttonColor ??
              AppColors.primaryColor.withOpacity(!isEnabled ? 0.5 : 1)),
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: (!replaceWithIndicator && isEnabled)
            ? () {
                if (onTap != null) {
                  HapticFeedback.lightImpact();
                  onTap!();
                }
              }
            : null,
        elevation: elevation ?? 0,
        highlightColor: Colors.transparent,
        focusElevation: 0,
        color: buttonColor ??
            AppColors.primaryColor.withOpacity(!isEnabled ? 0.5 : 1),
        child: Center(
          child: hasForwardIcon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buttonTitleWithLeadingIcon(context: context),
                    SizedBox(
                      width: 6,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.white,
                      size: 20,
                    )
                  ],
                )
              : replaceWithIndicator
                  ? DotProgressIndicator(
                      color: AppColors.white,
                    )
                  : buttonTitleWithLeadingIcon(
                      leadingIcon: leadingIcon, context: context),
        ),
      ),
    );
  }
}
