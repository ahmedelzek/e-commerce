import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/cart/cart_item_hive_model.dart';

class CartLocalDataSource {
  static const String _boxName = 'cart';
  late Box<CartItemHiveModel> _box;

  Future<void> init() async {
    _box = await Hive.openBox<CartItemHiveModel>(_boxName);
  }

  List<CartItemHiveModel> getAll() => _box.values.toList();

  Future<void> save(CartItemHiveModel item) async {
    await _box.put(item.productId, item);
  }

  Future<void> remove(int productId) async {
    await _box.delete(productId);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}