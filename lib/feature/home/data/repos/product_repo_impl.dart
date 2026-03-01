import 'package:auth_api_app/core/networking/api_endpoints.dart';
import 'package:auth_api_app/core/networking/dio_consumer.dart';
import 'package:auth_api_app/feature/auth/data/local_data_source/shared_pref.dart';
import 'package:auth_api_app/feature/home/data/models/products_model.dart';
import 'package:auth_api_app/feature/home/data/repos/products_repo.dart';
import 'package:dio/dio.dart';

class ProductsRepoImpl implements ProductsRepo {
  final LocalDateSource localDateSource;
  final ApiService apiService;

  const ProductsRepoImpl(this.apiService, this.localDateSource);

  @override
  Future<ProductsResponse> getProducts() async {
    try {
      final response = await apiService.get(ApiEndPoints.products);
      if (response.statusCode == 200) {
        return ProductsResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      return Future.error('Failed to load products: ${e.message}');
    }
  }
}
