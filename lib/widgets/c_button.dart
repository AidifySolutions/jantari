import 'package:flutter/material.dart';
import 'package:jantari/utils/styles.dart';
import 'package:jantari/utils/size_config.dart';

class CButton extends StatelessWidget {
  final String text;
  final bool lightTheme;
  final VoidCallback onPressed;
  final bool? applyPaddings;
  final Color? customBgColor;

  CButton({
    required this.text,
    required this.lightTheme,
    required this.onPressed,
    this.applyPaddings,
    this.customBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: (applyPaddings ?? false)
            ? EdgeInsets.only(
                left: SizeConfig.resizeWidth(3.7),
                right: SizeConfig.resizeWidth(3.7),
                bottom: SizeConfig.resizeWidth(5.85),
              )
            // ? EdgeInsets.symmetric(
            //     horizontal: SizeConfig.resizeWidth(3.7),
            //     vertical: SizeConfig.resizeWidth(5.85),
            //   )
            : const EdgeInsets.all(0),
        child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            foregroundColor:
                lightTheme ? customBgColor ?? CustomColors.customPrimaryColor : Colors.white,
            backgroundColor:
                lightTheme ? Colors.grey[200] : customBgColor ?? CustomColors.customPrimaryColor,
            side: BorderSide(
                width: 2, // the thickness
                color: customBgColor ?? CustomColors.customPrimaryColor // the color of the border
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  SizeConfig.resizeWidth(CustomSizes.customBorderRadius)),
              // borderRadius: BorderRadius.circular(15),
            ),
            minimumSize: const Size.fromHeight(45),
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              // fontSize: 16,
              fontSize: SizeConfig.resizeFont(CustomFonts.customBtnText),
            ),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
