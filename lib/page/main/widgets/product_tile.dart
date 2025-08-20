import 'package:flutter/material.dart';
import '../../../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 140,
        child: Card(
          elevation: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productImage(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      productName(),
                      productAdress(),
                      productPrice(),
                      Spacer(),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [productChat(), const SizedBox(width: 8), productLike()]),
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

  Text productPrice() => Text('${product.price}원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));

  Text productAdress() => Text(product.address, style: TextStyle(color: Colors.grey[600]));

  Text productName() {
    return Text(product.productName, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
  }

  ClipRRect productImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset("assets/sample_image/${product.imageFilename}.png", width: 100, height: 140, fit: BoxFit.cover),
    );
  }

  Row productChat() {
    return Row(children: [const Icon(Icons.forum_outlined, size: 16), Text('${product.chats}')]);
  }

  Row productLike() {
    return Row(children: [const Icon(Icons.favorite_border, size: 16), Text('${product.likes}')]);
  }
}
