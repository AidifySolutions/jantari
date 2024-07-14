import 'package:flutter/material.dart';
import 'package:jantari/utils/styles.dart';
import 'package:jantari/utils/size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String appBarText;
  final VoidCallback? onPressed;
  final bool implyLeading;

  CustomAppBar(
    this.context,
    this.appBarText,
    this.onPressed,
    this.implyLeading
  );

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          appBarText,
          style: TextStyle(
            fontSize: SizeConfig.resizeFont(CustomFonts.customAppBarText),
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      titleSpacing: 00.0,
      toolbarOpacity: 0.8,
      elevation: 0.00,
      backgroundColor: CustomColors.customPrimaryColor,
      automaticallyImplyLeading: implyLeading,
      leading: implyLeading ? IconButton(
        color: Colors.white,
        icon: Icon(Icons.arrow_back),
        iconSize: 20.0,
        onPressed: onPressed,
        // onPressed: () {
        //   Navigator.pop(context);
        // },
      ) : null,
    );
  }
}
