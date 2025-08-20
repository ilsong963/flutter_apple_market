import 'package:apple_market/models/product.dart';
import 'package:apple_market/page/detail/detail_page.dart';
import 'package:apple_market/provider/product_notifier.dart';
import 'package:apple_market/util/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductTile extends ConsumerWidget {
  const ProductTile({super.key, required this.productId});
  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(productNotifierProvider.notifier);

    final product = ref.watch(productByIdProvider(productId));
    return GestureDetector(
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(productId: productId)));
      },
      onLongPress: () {
        deleteProduct(context, notifier);
      },
      child: SizedBox(
        height: 140,
        child: Card(
          elevation: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productImage(product!),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      productName(product),
                      productAdress(product),
                      productPrice(product),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          productChat(product),
                          const SizedBox(width: 8),
                          Icon(product.isLike ? Icons.favorite : Icons.favorite_border, color: product.isLike ? Colors.red : Colors.grey, size: 16),
                          Text('${product.likes}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> deleteProduct(BuildContext context, ProductNotifier notifier) {
    print(productId);
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("상품 삭제"),
            content: const Text("이 상품을 삭제하시겠습니까?"),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("취소")),
              TextButton(
                onPressed: () {
                  notifier.removeProductById(productId);
                  Navigator.of(context).pop();
                },
                child: const Text("확인"),
              ),
            ],
          ),
    );
  }

  Text productPrice(Product product) =>
      Text('${Formatter.formatPrice(product.price)} 원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));

  Text productAdress(Product product) => Text(product.address, style: TextStyle(color: Colors.grey[600]));

  Text productName(Product product) {
    return Text(product.productName, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
  }

  ClipRRect productImage(Product product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset("assets/sample_image/${product.imageFilename}.png", width: 100, height: 140, fit: BoxFit.cover),
    );
  }

  Row productChat(Product product) {
    return Row(children: [const Icon(Icons.forum_outlined, size: 16), Text('${product.chats}')]);
  }
}
