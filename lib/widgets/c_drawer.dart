import 'package:jantari/bloc/auth/bloc.dart';
import 'package:jantari/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/styles.dart';

class CustomDrawer extends StatefulWidget {
  final Function(int) onSelected;
  final int selectedDrawerIndex;

  const CustomDrawer({
    Key? key,
    required this.onSelected,
    required this.selectedDrawerIndex,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          drawerHeader(),
          drawerTile(Icons.home, "Workflows", 0),
          drawerTile(Icons.fingerprint, "Biometric Verification", 1),
          const Divider(),
          drawerTile(Icons.exit_to_app, "Logout", 2, logout: true),
          const Spacer(),
          const Divider(
            height: 1,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: const Text(
              '2022 \u00a9 Unikrew Solutions',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: CustomColors.customPrimaryColor),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: CustomColors.customPrimaryColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(60),
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                state.authStateModel.userDetail?.name ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                state.authStateModel.userDetail?.emailAddress ?? "",
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget drawerTile(IconData icon, String title, int index,
      {bool logout = false}) {
    Color bgColor = widget.selectedDrawerIndex == index
        ? CustomColors.customPrimaryLighterColor
        : Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: CustomColors.customPrimaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(color: CustomColors.customPrimaryColor),
        ),
        onTap: () {
          logout
              ? logoutUser()
              : setState(
                  () {
                    widget.onSelected(index);
                  },
                );
        },
      ),
    );
  }

  logoutUser() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (Route<dynamic> route) => false);
  }
}
