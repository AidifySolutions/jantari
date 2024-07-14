part of 'bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {
  const FetchProducts();

  List<Object> get props => [];
}

class FetchProduct extends ProductEvent {
  const FetchProduct(this.productCode);

  final String productCode;

  List<Object> get props => [productCode];
}
