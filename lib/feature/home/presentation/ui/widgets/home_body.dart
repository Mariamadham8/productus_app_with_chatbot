import 'package:auth_api_app/feature/home/presentation/ui/widgets/porduct_tap_bar.dart';
import 'package:auth_api_app/feature/home/presentation/ui/widgets/product_listview.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),

        Center(child: ProductsTabBar(onTabChanged: (index) {})),

        const SizedBox(height: 12),

        Expanded(child: ProductsListView()),
      ],
    );
  }
}
