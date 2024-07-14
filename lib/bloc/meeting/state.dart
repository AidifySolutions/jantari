part of 'bloc.dart';

class MeetingState extends Equatable {
  final MeetingStateModel meetingStateModel;

  const MeetingState({
    required this.meetingStateModel,
  });

  @override
  List<Object?> get props => [meetingStateModel];
}

class MeetingStateInitial extends MeetingState {
  const MeetingStateInitial() : super(meetingStateModel: const MeetingStateModel());
}

class MeetingStateLoading extends MeetingState {
  final MeetingStateModel meetingStateModel;

  const MeetingStateLoading({required this.meetingStateModel}) : super(meetingStateModel: meetingStateModel);
}

class MeetingStateLoaded extends MeetingState {
  final MeetingStateModel meetingStateModel;

  const MeetingStateLoaded({required this.meetingStateModel})
      : super(meetingStateModel: meetingStateModel);
}

class MeetingStateFailed extends MeetingState {
  final MeetingStateModel meetingStateModel;

  const MeetingStateFailed({required this.meetingStateModel})
      : super(meetingStateModel: meetingStateModel);
}
class MeetingsStateLoading extends MeetingState {
  final MeetingStateModel meetingStateModel;

  const MeetingsStateLoading({required this.meetingStateModel}) : super(meetingStateModel: meetingStateModel);
}

class MeetingsStateLoaded extends MeetingState {
  final MeetingStateModel meetingStateModel;

  const MeetingsStateLoaded({required this.meetingStateModel})
      : super(meetingStateModel: meetingStateModel);
}

class MeetingsStateFailed extends MeetingState {
  final MeetingStateModel meetingStateModel;

  const MeetingsStateFailed({required this.meetingStateModel})
      : super(meetingStateModel: meetingStateModel);
}
