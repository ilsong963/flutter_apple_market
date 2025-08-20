import 'package:apple_market/page/detail/detail_page.dart';
import 'package:apple_market/util/formatter.dart';
import 'package:flutter/material.dart';
import '../../../models/product.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  final Function() onLongPress;
  final ValueChanged<bool> onLikeChanged;
  const ProductTile({super.key, required this.product, required this.onLongPress, required this.onLikeChanged});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push<bool>(
          context,
          MaterialPageRoute(
            builder:
                (context) => DetailPage(
                  product: widget.product,
                  isLike: isLike,
                  onLikeChanged: (value) {
                    widget.onLikeChanged(value);
                    setState(() {
                      isLike = value;
                    });
                  },
                ),
          ),
        );
      },
      onLongPress: widget.onLongPress,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          productChat(),
                          const SizedBox(width: 8),
                          Icon(isLike ? Icons.favorite : Icons.favorite_border, color: isLike ? Colors.red : Colors.grey, size: 16),
                          Text('${widget.product.likes}'),
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

  Text productPrice() => Text('${Formatter.formatPrice(widget.product.price)} 원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));

  Text productAdress() => Text(widget.product.address, style: TextStyle(color: Colors.grey[600]));

  Text productName() {
    return Text(
      widget.product.productName,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  ClipRRect productImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset("assets/sample_image/${widget.product.imageFilename}.png", width: 100, height: 140, fit: BoxFit.cover),
    );
  }

  Row productChat() {
    return Row(children: [const Icon(Icons.forum_outlined, size: 16), Text('${widget.product.chats}')]);
  }
}
