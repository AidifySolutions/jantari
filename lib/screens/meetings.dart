import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jantari/bloc/auth/bloc.dart';

// BLoCs
import 'package:jantari/bloc/meeting/bloc.dart';

// Utilities
import 'package:jantari/utils/size_config.dart';
import 'package:jantari/utils/helper.dart';
import 'package:jantari/utils/styles.dart';

Timer? timer;

class Meetings extends StatefulWidget {
  final int room;

  const Meetings({Key? key, required this.room}) : super(key: key);

  @override
  State<Meetings> createState() => _MeetingsState();
}

class _MeetingsState extends State<Meetings> {
  bool isMeetingOngoing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is ClientCredentialsLoaded) {
              timer = Timer.periodic(const Duration(seconds: 30), (Timer t) => {
                context.read<MeetingBloc>().add(FetchMeetings(widget.room))
              });
            }
          },
          child: Container(),
        ),
        BlocBuilder<MeetingBloc, MeetingState>(
          builder: (context, state) {
            if (state is MeetingsStateLoading) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is MeetingsStateFailed) {
              var errorResponse = context.select(
                      (MeetingBloc bloc) => bloc.state.meetingStateModel.errorMessage);

              try {
                if(errorResponse["error"]?["code"] == "InvalidAuthenticationToken") {
                  context.read<AuthBloc>().add(const GenerateTokenFromClientCredentials());
                }
              } catch (e) {
                print(e);
                context.read<MeetingBloc>().add(FetchMeetings(widget.room));
              }

            } else {
              var meetings = context.select(
                      (MeetingBloc bloc) => bloc.state.meetingStateModel.meetings);

              var upcomingMeetingTimeDifference = 0;
              var isUpcomingMeetingTimeDifferenceSet = false;
              var activeMeetingIndex = null;

              for (var element in (meetings ?? [])) {
                DateTime earlierDate = DateTime.now().toUtc();
                DateTime laterDate = DateTime.parse(element.start!.dateTime)
                    .add(const Duration(hours: 5));
                Duration difference = laterDate.difference(earlierDate);
                int differenceInMinutes = difference.inMinutes;

                if (isUpcomingMeetingTimeDifferenceSet == false &&
                    differenceInMinutes > 0) {
                  upcomingMeetingTimeDifference = differenceInMinutes;
                  isUpcomingMeetingTimeDifferenceSet = true;
                } else if (differenceInMinutes <
                    upcomingMeetingTimeDifference) {
                  upcomingMeetingTimeDifference = differenceInMinutes;
                }
              }

              return Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                    child: meetings != null && meetings.isNotEmpty
                        ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          upcomingMeetingTimeDifference > 0 &&
                              isMeetingOngoing == false ? Column(
                            children: [
                              SizedBox(
                                  height: SizeConfig.resizeWidth(4.7)),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.resizeWidth(3),
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Image.asset("assets/empty-room.jpg", fit: BoxFit.cover),
                                        ListTile(
                                            title: Text(
                                              "Vacant till ${Helper.minutesToReadableTime(upcomingMeetingTimeDifference)}",
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                    .resizeFont(
                                                  CustomFonts.customHeadingTwo,
                                                ),
                                                fontWeight:
                                                FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.center,
                                            )
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ) : Container(),
                          ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                  height: SizeConfig.resizeWidth(4.7));
                            },
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.resizeWidth(3.7),
                              vertical: SizeConfig.resizeWidth(4),
                            ),
                            itemCount: meetings.length,
                            itemBuilder: (context, index) {
                              final item = meetings[index];
                              var parsedStartTime = DateTime.parse(
                                  '${item.start!.dateTime}')
                                  .add(const Duration(hours: 5));
                              var parsedEndTime =
                              DateTime.parse('${item.end!.dateTime}')
                                  .add(const Duration(hours: 5));

                              DateTime earlierDate = DateTime.now().toUtc();
                              Duration startTimeDifference =
                              parsedStartTime.difference(earlierDate);
                              Duration endTimeDifference =
                              parsedEndTime.difference(earlierDate);
                              int startDifferenceInMinutes = startTimeDifference.inMinutes;
                              int endDifferenceInMinutes = endTimeDifference.inMinutes;

                              // print("startDifferenceInMinutes $startDifferenceInMinutes, endDifferenceInMinutes $endDifferenceInMinutes");

                              if(startDifferenceInMinutes < 0 &&
                                  endDifferenceInMinutes > 0 &&
                                  activeMeetingIndex == null) {
                                activeMeetingIndex = index;

                                if(isMeetingOngoing == false) {
                                  WidgetsBinding.instance.addPostFrameCallback((_){
                                    setState(() {
                                      isMeetingOngoing = true;
                                    });
                                  });
                                }
                              }

                              return ListTile(
                                  contentPadding: EdgeInsets.all(
                                      SizeConfig.resizeWidth(2)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.resizeWidth(1)),
                                  ),
                                  tileColor: activeMeetingIndex ==
                                      index ?  const Color.fromRGBO(
                                      170, 232, 170, 1.0) :
                                  Colors
                                      .white70,
                                  title: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Text(
                                                  DateFormat.jm().format(
                                                      parsedStartTime),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: SizeConfig
                                                        .resizeFont(
                                                      CustomFonts
                                                          .customListTileTitle,
                                                    ),
                                                    fontWeight:
                                                    FontWeight.w700,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.arrow_right_alt,
                                                  size: 40,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  DateFormat.jm().format(
                                                      parsedEndTime),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: SizeConfig
                                                        .resizeFont(
                                                      CustomFonts
                                                          .customListTileTitle,
                                                    ),
                                                    fontWeight:
                                                    FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceAround,
                                        children: [
                                          Center(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: const [
                                                    Text("Organized By",
                                                        style: TextStyle(
                                                            fontSize:
                                                            14),
                                                        textAlign:
                                                        TextAlign
                                                            .center),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        (meetings![index]
                                                            ?.organizer
                                                            ?.emailAddress
                                                            ?.name ??
                                                            "N/A"),
                                                        style:
                                                        const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                        ),
                                                        textAlign:
                                                        TextAlign
                                                            .center),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ));
                            },
                          ),
                        ],
                      ),
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No booking found!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: SizeConfig.resizeFont(
                                        CustomFonts.customHeadingThree),
                                    fontWeight: FontWeight.w600),
                              ),
                            ])
                      ],
                    )),
              );
            }

            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

