import 'package:flutter/material.dart';
import 'package:jantari/utils/styles.dart';
import 'package:jantari/utils/size_config.dart';

class CustomCard extends StatelessWidget {
  final VoidCallback onTap;
  final String? leadingImage;
  final String title;

  CustomCard({
    required this.onTap,
    this.leadingImage,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.resizeWidth(CustomSizes.customBorderRadius))),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.resizeWidth(4.11)),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leadingImage != null ?
              Image.asset(
                leadingImage!,
                height: SizeConfig.resizeWidth(13.4),
                width: SizeConfig.resizeWidth(13.4),
              ) : Container(),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.resizeWidth(4.11)),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: SizeConfig.resizeFont(
                        CustomFonts.customListTileTitle,
                      ),
                    ),
                  ),
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: Colors.black87,
                size: SizeConfig.resizeWidth(6.31),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
