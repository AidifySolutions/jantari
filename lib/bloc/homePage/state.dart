part of 'bloc.dart';

class HomePageState {
  bool? isResident;
  String? productType;
  String? accountType;
  Map? selfieFile;

  HomePageState({
    this.isResident,
    this.productType,
    this.accountType,
    this.selfieFile,
  });

  HomePageState copyWith({
    bool? isResident,
    String? productType,
    String? accountType,
    Map? selfieFile,
  }) {
    return HomePageState(
      isResident: isResident ?? this.isResident,
      productType: productType ?? this.productType,
      accountType: accountType ?? this.accountType,
      selfieFile: selfieFile ?? this.selfieFile,
    );
  }
}
