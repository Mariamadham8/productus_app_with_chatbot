import 'package:flutter/material.dart';
import 'product_card.dart';

class ProductsListView extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ProductsListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 12, bottom: 24),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          title: product['title'] ?? '',
          subtitle: product['description'] ?? '',
          price: product['price'].toString(),
          rating: (product['rating'] as num?)?.toDouble() ?? 0.0,
          reviewsCount: product['stock'] ?? 0,
          imageUrl: product['thumbnail'] ?? '',
        );
      },
    );
  }
}
