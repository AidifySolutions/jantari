part of 'bloc.dart';

class ProductState extends Equatable {
  final ProductStateModel productStateModel;

  const ProductState({
    required this.productStateModel,
  });

  @override
  List<Object?> get props => [productStateModel];
}

class ProductStateInitial extends ProductState {
  const ProductStateInitial() : super(productStateModel: const ProductStateModel());
}

class ProductStateLoading extends ProductState {
  final ProductStateModel productStateModel;

  const ProductStateLoading({required this.productStateModel}) : super(productStateModel: productStateModel);
}

class ProductStateLoaded extends ProductState {
  final ProductStateModel productStateModel;

  const ProductStateLoaded({required this.productStateModel})
      : super(productStateModel: productStateModel);
}

class ProductStateFailed extends ProductState {
  final ProductStateModel productStateModel;

  const ProductStateFailed({required this.productStateModel})
      : super(productStateModel: productStateModel);
}
class ProductsStateLoading extends ProductState {
  final ProductStateModel productStateModel;

  const ProductsStateLoading({required this.productStateModel}) : super(productStateModel: productStateModel);
}

class ProductsStateLoaded extends ProductState {
  final ProductStateModel productStateModel;

  const ProductsStateLoaded({required this.productStateModel})
      : super(productStateModel: productStateModel);
}

class ProductsStateFailed extends ProductState {
  final ProductStateModel productStateModel;

  const ProductsStateFailed({required this.productStateModel})
      : super(productStateModel: productStateModel);
}
