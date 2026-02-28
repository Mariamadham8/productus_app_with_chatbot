import 'package:auth_api_app/feature/home/data/models/product_model.dart';

class ProductsResponse {
  List<Product>? products;

  ProductsResponse({this.products});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      products: json['products'] != null
          ? List<Product>.from(json['products'].map((x) => Product.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'products': products?.map((x) => x.toJson()).toList()};
  }
}
