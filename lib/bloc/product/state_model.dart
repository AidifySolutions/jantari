import 'package:jantari/models/product.dart';
import 'package:equatable/equatable.dart';

class ProductStateModel extends Equatable {
  const ProductStateModel({
    this.product,
    this.products,
    this.errorMessage
  });

  final Product? product;
  final List<Product>? products;
  final String? errorMessage;

  ProductStateModel copyWith({
    Product? product,
    List<Product>? products,
    String? errorMessage
  }) {
    return ProductStateModel(
      product: product ?? this.product,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [product, products];
}
