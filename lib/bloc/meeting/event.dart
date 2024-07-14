part of 'bloc.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props => [];
}

class FetchMeetings extends MeetingEvent {
  const FetchMeetings(this.room);

  final int room;

  List<Object> get props => [room];
}
