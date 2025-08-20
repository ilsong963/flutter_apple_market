import 'package:apple_market/page/main/widgets/product_tile_listview.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text("르탄동"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none_outlined))],
      ),
      body: ProductTileListView(),
    );
  }
}
