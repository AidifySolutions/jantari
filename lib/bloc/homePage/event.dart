part of 'bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class SetIsResident extends HomePageEvent {
  const SetIsResident(this.isResident);

  final bool isResident;

  @override
  List<Object> get props => [isResident];
}

class SetProductType extends HomePageEvent {
  const SetProductType(this.productType);

  final String productType;

  @override
  List<Object> get props => [productType];
}

class SetSelfieFile extends HomePageEvent {
  const SetSelfieFile(this.selfieFile);

  final Map selfieFile;

  @override
  List<Object> get props => [selfieFile];
}