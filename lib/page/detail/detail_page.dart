import 'package:apple_market/models/product.dart';
import 'package:apple_market/page/detail/widgets/bottom_bar.dart';
import 'package:apple_market/util/formatter.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  final bool isLike;
  final ValueChanged<bool> onLikeChanged;
  const DetailPage({super.key, required this.product, required this.isLike, required this.onLikeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("상품 상세")),

      bottomNavigationBar: BottomBar(product: product, isLike: isLike, onLikeChanged: onLikeChanged),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/sample_image/${product.imageFilename}.png", height: 250, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [profileRow(), const SizedBox(height: 12), const Divider(), productName(), const SizedBox(height: 8), productDescription()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text productDescription() => Text(Formatter.formatMultiline(product.description), style: TextStyle(fontSize: 15));

  Text productName() => Text(product.productName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  Row profileRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [profileImage(), const SizedBox(width: 8), profileInfo(), profileTemperature()],
    );
  }

  Column profileTemperature() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        Text("39.3 ℃", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
        Text(
          "매너온도",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            decoration: TextDecoration.underline,
            decorationThickness: 2,
            decorationColor: Colors.grey,
          ),
        ),
      ],
    );
  }

  Expanded profileInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.seller, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 2),
          Text(product.address, style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  CircleAvatar profileImage() =>
      CircleAvatar(radius: 20, backgroundColor: Colors.orange, child: const Icon(size: 30, Icons.person, color: Colors.white));
}
