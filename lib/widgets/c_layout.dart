import 'package:jantari/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:jantari/widgets/c_drawer.dart';
import 'package:jantari/utils/size_config.dart';

class CustomScreenLayout extends StatefulWidget {
  final bool? resizeToAvoidBottomInset;
  final Widget content;
  final String? heading;
  final Widget? bottomNavigation;

  CustomScreenLayout({
    this.resizeToAvoidBottomInset,
    required this.content,
    this.heading,
    this.bottomNavigation,
  });

  @override
  State<CustomScreenLayout> createState() => _CustomScreenLayoutState();
}

class _CustomScreenLayoutState extends State<CustomScreenLayout> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      drawer: CustomDrawer(
        selectedDrawerIndex: 0,
        onSelected: (index) {
          Navigator.pop(context);
          // setState(() {
          //   _selectedDrawerIndex = index;
          // });
        },
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              appHeader(),
              appBody(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.bottomNavigation,
    );
  }

  Widget appHeader() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                  // "Meeting Room Slots",
                "Test",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.resizeFont(CustomFonts.customHeadingTwo),
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBody() {
    return Expanded(
      child: widget.content
    );
  }
}
