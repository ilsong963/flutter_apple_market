import 'package:apple_market/page/main/widgets/product_tile.dart';
import 'package:apple_market/provider/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductTileListView extends ConsumerWidget {
  const ProductTileListView({super.key, required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: productState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stack) => Center(child: Text('에러 발생: $e')),
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('상품이 없습니다.'));
          }
          return ListView.builder(
            controller: controller,
            itemCount: products.length * 2 - 1,
            itemBuilder: (context, index) {
              if (index.isOdd) return const Divider(height: 20, color: Colors.grey);

              final productIndex = index ~/ 2;
              final product = products[productIndex];

              return ProductTile(productId: product.id);
            },
          );
        },
      ),
    );
  }
}
