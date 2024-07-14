import 'package:jantari/models/meeting.dart';
import 'package:equatable/equatable.dart';

class MeetingStateModel extends Equatable {
  const MeetingStateModel({
    this.meeting,
    this.meetings,
    this.errorMessage
  });

  final Meeting? meeting;
  final List<Meeting>? meetings;
  final dynamic errorMessage;

  MeetingStateModel copyWith({
    Meeting? meeting,
    List<Meeting>? meetings,
    dynamic errorMessage
  }) {
    return MeetingStateModel(
      meeting: meeting ?? this.meeting,
      meetings: meetings ?? this.meetings,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [meeting, meetings];
}
