import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:jantari/bloc/auth/bloc.dart';

// BLoCs
import 'package:jantari/bloc/meeting/bloc.dart';

// Utilities
import 'package:jantari/utils/size_config.dart';
import 'package:jantari/utils/helper.dart';
import 'package:jantari/utils/styles.dart';

import 'meetings.dart';

class Main extends StatefulHookWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool isMeetingOngoing = false;
  int selectedTab = 0;

  final List<Tab> rooms = <Tab>[
    const Tab(child: Text('Room 1')),
    const Tab(child: Text('Room 2')),
  ];

  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(const GenerateTokenFromClientCredentials());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return DefaultTabController(
      length: rooms.length,
      child: Builder(builder: (BuildContext context) {

        final TabController roomsController = DefaultTabController.of(context)!;
        roomsController.addListener(() {
          if (!roomsController.indexIsChanging) {
            if(roomsController.index != selectedTab) {
              context.read<MeetingBloc>().add(FetchMeetings(roomsController.index));
            }
            setState(() {
              selectedTab = roomsController.index;
            });
          }
        });

          return Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                  controller: roomsController,
                  tabs: rooms
              ),
              title: const Center(child: Text("Booking Slots")),
              backgroundColor: const Color(0xFF091a33),
            ),
            body: TabBarView(
              controller: roomsController,
              children: rooms.map((Tab tab) {
                return Meetings(room: selectedTab);
              }).toList(),
            ),
          );
        }
      ),
    );
  }
}
