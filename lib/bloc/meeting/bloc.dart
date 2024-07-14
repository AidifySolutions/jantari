import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:jantari/bloc/meeting/state_model.dart';
import 'package:equatable/equatable.dart';

// Repositories
import 'package:jantari/repositories/meeting.dart';

part 'event.dart';

part 'state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  MeetingBloc({required MeetingRepository meetingRepository})
      : _meetingRepository = meetingRepository,
        super(const MeetingStateInitial()) {
    on<FetchMeetings>(_onFetchMeetings);
  }

  final MeetingRepository _meetingRepository;

  Future<void> _onFetchMeetings(
    FetchMeetings event,
    Emitter<MeetingState> emit,
  ) async {
    emit(MeetingsStateLoading(meetingStateModel: state.meetingStateModel));

    try {
      final meetingsResponse = await _meetingRepository.getMeetings(event.room);

      emit(
        MeetingsStateLoaded(
          meetingStateModel: state.meetingStateModel.copyWith(
            meetings: meetingsResponse,
          ),
        ),
      );
    } catch (e) {
      emit(
        MeetingsStateFailed(
          meetingStateModel: state.meetingStateModel.copyWith(
            errorMessage: e,
          ),
        ),
      );
    }
  }
}
