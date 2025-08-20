import 'package:apple_market/models/product.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productNotifierProvider = AsyncNotifierProvider<ProductNotifier, List<Product>>(ProductNotifier.new);
final productByIdProvider = Provider.family<Product?, int>((ref, id) {
  final list = ref.watch(productNotifierProvider).value;
  if (list == null) return null;
  try {
    return list.firstWhere((p) => p.id == id);
  } catch (e) {
    return null;
  }
});

class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  build() async {
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
            isLike: false,
          );
        }).toList();
    return items;
  }

  void removeProductById(int productId) {
    final current = state.value;
    if (current == null) return;

    final updated = current.where((product) => product.id != productId).toList();
    state = AsyncValue.data(updated);
  }

  void changeProductLikeById(bool isLiked, int productId) {
    final current = state.value;
    if (current == null) return;

    final updatedList = [...current];
    final index = updatedList.indexWhere((product) => product.id == productId);
    if (index == -1) return;

    final target = updatedList[index];
    updatedList[index] = target.copyWith(isLike: isLiked, likes: isLiked ? target.likes + 1 : target.likes - 1);
    state = AsyncValue.data(updatedList);
  }
}
