import 'package:apple_market/models/product.dart';
import 'package:apple_market/page/detail/widgets/like_button.dart';
import 'package:apple_market/util/formatter.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final Product product;
  final bool isLike;
  final ValueChanged<bool> onLikeChanged;
  const BottomBar({super.key, required this.product, required this.isLike, required this.onLikeChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LikeButton(isLike: isLike, onLikeChanged: onLikeChanged),
          Text('${Formatter.formatPrice(product.price)} 원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('채팅하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
