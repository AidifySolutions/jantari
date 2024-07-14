import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:jantari/bloc/product/state_model.dart';
import 'package:equatable/equatable.dart';

// Repositories
import 'package:jantari/repositories/product.dart';

part 'event.dart';

part 'state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(const ProductStateInitial()) {
    on<FetchProduct>(_onFetchProduct);
    on<FetchProducts>(_onFetchProducts);
  }

  final ProductRepository _productRepository;

  Future<void> _onFetchProduct(
    FetchProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      ProductStateLoading(
        productStateModel: state.productStateModel.copyWith(
          product: null,
        ),
      ),
    );

    try {
      final productResponse = await _productRepository.getProduct(
          productCode: event.productCode
      );

      emit(
        ProductStateLoaded(
          productStateModel: state.productStateModel.copyWith(
            product: productResponse,
          ),
        ),
      );
    } catch (e) {
      emit(
        ProductStateFailed(
          productStateModel: state.productStateModel.copyWith(
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductsStateLoading(productStateModel: state.productStateModel));

    try {
      final productsResponse = await _productRepository.getProducts();

      emit(
        ProductsStateLoaded(
          productStateModel: state.productStateModel.copyWith(
            products: productsResponse,
          ),
        ),
      );
    } catch (e) {
      emit(
        ProductsStateFailed(
          productStateModel: state.productStateModel.copyWith(
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }
}
