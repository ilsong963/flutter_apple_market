import 'package:apple_market/models/product.dart';
import 'package:apple_market/page/main/widgets/product_tile.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductTileListView extends StatefulWidget {
  const ProductTileListView({super.key, required this.controller});
  final ScrollController controller;

  @override
  State<ProductTileListView> createState() => _ProductTileListViewState();
}

class _ProductTileListViewState extends State<ProductTileListView> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final rawData = await rootBundle.loadString('assets/data/dummy_data.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    final items =
        listData.skip(2).map((row) {
          return Product(
            id: int.tryParse(row[0].toString()) ?? 0,
            imageFilename: row[1].toString(),
            productName: row[2].toString(),
            description: row[3].toString(),
            seller: row[4].toString(),
            price: int.tryParse(row[5].toString()) ?? 0,
            address: row[6].toString(),
            likes: int.tryParse(row[7].toString()) ?? 0,
            chats: int.tryParse(row[8].toString()) ?? 0,
          );
        }).toList();
    setState(() {
      products = items;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                controller: widget.controller,
                itemCount: products.length * 2 - 1,
                itemBuilder: (context, index) {
                  //홀수 일때 구분선 추가
                  if (index.isOdd) {
                    return Divider(color: Colors.grey, height: 20);
                  }
                  final productIndex = index ~/ 2;
                  return ProductTile(
                    product: products[productIndex],
                    onLikeChanged: (isLiked) {
                      setState(() {
                        if (isLiked) {
                          products[productIndex] = products[productIndex].copyWith(likes: products[productIndex].likes + 1);
                        } else {
                          products[productIndex] = products[productIndex].copyWith(likes: products[productIndex].likes - 1);
                        }
                      });
                    },
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("상품 삭제"),
                            content: Text("이 상품을 삭제하시겠습니까?"),
                            actions: [
                              TextButton(
                                child: Text('취소'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('확인'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    products.removeAt(productIndex);
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
    );
  }
}
