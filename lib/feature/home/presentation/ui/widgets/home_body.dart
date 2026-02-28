import 'package:auth_api_app/feature/home/presentation/ui/widgets/porduct_tap_bar.dart';
import 'package:auth_api_app/feature/home/presentation/ui/widgets/product_listview.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final bool isLoading;
  final String? errorMessage;

  const HomeScreenBody({
    super.key,
    required this.products,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),

        // Tab bar
        ProductsTabBar(onTabChanged: (index) {}),

        const SizedBox(height: 12),

        // Content
        Expanded(child: _buildContent()),
      ],
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Text(errorMessage!, style: const TextStyle(color: Colors.red)),
      );
    }

    if (products.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return ProductsListView(products: products);
  }
}
