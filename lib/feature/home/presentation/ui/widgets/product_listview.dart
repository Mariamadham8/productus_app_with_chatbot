import 'package:auth_api_app/core/widgets/app_snack_bar.dart';
import 'package:auth_api_app/feature/home/presentation/manger/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_card.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductFailure) {
          AppSnackBar.showError(context, state.error.toString());
        }
      },

      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            itemCount: state.productsResponse.products!.length,
            itemBuilder: (context, index) {
              final product = state.productsResponse.products![index];
              return ProductCard(
                title: product.title ?? '',
                subtitle: product.description ?? '',
                price: product.price ?? 0.0,
                rating: product.rating ?? 0.0,
                reviewsCount: product.reviews!.length,
                imageUrl: product.thumbnail ?? '',
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
