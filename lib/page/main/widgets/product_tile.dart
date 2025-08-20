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
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset("assets/sample_image/${product.imageFilename}.png", width: 100, height: 140, fit: BoxFit.cover),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(product.address, style: TextStyle(color: Colors.grey[600])),
                      Text('${product.price}원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.forum_outlined, size: 16),
                          Text('${product.chats}'),
                          const SizedBox(width: 8),
                          const Icon(Icons.favorite_border, size: 16),
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
}
