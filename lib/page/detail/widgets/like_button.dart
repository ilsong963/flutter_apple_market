import 'package:apple_market/provider/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeButton extends ConsumerStatefulWidget {
  final int productId;

  const LikeButton({super.key, required this.productId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LikeButtonState();
}

class _LikeButtonState extends ConsumerState<LikeButton> {
  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productByIdProvider(widget.productId));
    final notifier = ref.read(productNotifierProvider.notifier);

    return IconButton(
      onPressed: () {
        notifier.changeProductLikeById(!product.isLike, widget.productId);
      },
      icon: Icon(product!.isLike ? Icons.favorite : Icons.favorite_border, color: product.isLike ? Colors.red : Colors.grey),
    );
  }
}
