import 'package:flutter/material.dart';

import 'package:jantari/widgets/c_button.dart';
import 'package:jantari/utils/size_config.dart';
import 'package:jantari/utils/styles.dart';

class CustomPermissionDialog extends StatelessWidget {
  final String permissionType;

  const CustomPermissionDialog({Key? key, required this.permissionType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.resizeWidth(3.6)),
      ),
      insetPadding: EdgeInsets.all(SizeConfig.resizeWidth(5.15)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.39,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(SizeConfig.resizeWidth(5.15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.resizeWidth(2.98),
            ),
            Icon(
              Icons.warning_rounded,
              color: Colors.black,
              size: SizeConfig.resizeWidth(20.31),
            ),
            SizedBox(
              height: SizeConfig.resizeWidth(2.98),
            ),
            Text(
              "Permission Required",
              style: TextStyle(
                fontSize: SizeConfig.resizeFont(CustomFonts.customHeadingThree),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: SizeConfig.resizeWidth(4.98),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.resizeWidth(3),
              ),
              child: Text(
                "App requires $permissionType access. In order to proceed go to the app settings and allow the $permissionType permission.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.resizeFont(CustomFonts.customParagraph),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.resizeWidth(4.98),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.resizeWidth(3.7),
              ),
              child: CButton(
                text: "Go to Settings",
                lightTheme: false,
                applyPaddings: true,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
