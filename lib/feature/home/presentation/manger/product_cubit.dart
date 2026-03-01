import 'package:auth_api_app/feature/home/data/models/products_model.dart';
import 'package:auth_api_app/feature/home/data/repos/products_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductsRepo productsRepo;
  ProductCubit(this.productsRepo) : super(ProductInitial());

  Future<void> fetchProducts() async {
    try {
      emit(ProductLoading());
      final productsResponse = await productsRepo.getProducts();
      emit(ProductSuccess(productsResponse));
    } catch (error) {
      emit(ProductFailure(error.toString()));
    }
  }
}
