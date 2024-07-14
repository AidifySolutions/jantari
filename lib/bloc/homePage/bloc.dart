import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';

part 'state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageState()) {
    on<SetIsResident>(_onSetIsResident);
    on<SetProductType>(_onSetProductType);
    on<SetSelfieFile>(_onSetSelfieFile);
  }

  Future<void> _onSetIsResident(
    SetIsResident event,
    Emitter<HomePageState> emit,
  ) async {
    emit(
      state.copyWith(isResident: event.isResident),
    );
  }

  Future<void> _onSetProductType(
      SetProductType event,
      Emitter<HomePageState> emit,
      ) async {
    emit(
      state.copyWith(productType: event.productType),
    );
  }

  Future<void> _onSetSelfieFile(
      SetSelfieFile event,
      Emitter<HomePageState> emit,
      ) async {
    emit(
      state.copyWith(selfieFile: event.selfieFile),
    );
  }
}
