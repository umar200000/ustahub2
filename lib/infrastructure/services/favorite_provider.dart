import 'package:flutter/foundation.dart';

class FavoriteServiceItem {
  final String id;
  final String name;
  final String profession;
  final String? imageUrl;
  final int priceFrom;
  final String? provinceName;
  final bool isAvailable;
  final String? providerName;

  const FavoriteServiceItem({
    required this.id,
    required this.name,
    required this.profession,
    this.imageUrl,
    required this.priceFrom,
    this.provinceName,
    this.isAvailable = true,
    this.providerName,
  });
}

class FavoriteProvider extends ChangeNotifier {
  final Map<String, FavoriteServiceItem> _items = {};

  List<FavoriteServiceItem> get items => _items.values.toList();

  int get count => _items.length;

  bool contains(String id) => _items.containsKey(id);

  void toggle(FavoriteServiceItem item) {
    if (_items.containsKey(item.id)) {
      _items.remove(item.id);
    } else {
      _items[item.id] = item;
    }
    notifyListeners();
  }

  void remove(String id) {
    if (_items.remove(id) != null) {
      notifyListeners();
    }
  }

  void clear() {
    if (_items.isEmpty) return;
    _items.clear();
    notifyListeners();
  }
}
