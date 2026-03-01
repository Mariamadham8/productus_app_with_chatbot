part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final ProductsResponse productsResponse;
  ProductSuccess(this.productsResponse);
}

class ProductFailure extends ProductState {
  final String error;
  ProductFailure(this.error);
}
