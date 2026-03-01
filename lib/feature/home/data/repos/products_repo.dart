import 'package:auth_api_app/feature/home/data/models/products_model.dart';

abstract class ProductsRepo {
  Future<ProductsResponse> getProducts();
}
