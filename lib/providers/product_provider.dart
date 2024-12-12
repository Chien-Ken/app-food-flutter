import 'dart:convert';

import 'package:app_food/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> getItemsWithCategoryId(String categoryId) {
    return _items.where((element) => element.categoryId == categoryId).toList();
  }

  Product getItemWithId(id) {
    return _items.singleWhere((element) => element.id == id);
  }

  List<Product> getItemsIsFavorite() {
    return _items.where((element) => element.isFavorite).toList();
  }

  List<Product> getItemsIsSeen() {
    return _items.where((element) => element.isSeen).toList();
  }

  Future<void> loadFavoriteStates() async {
    for (var product in _items) {
      await product.loadFavoriteState();
    }
    notifyListeners();  // Only call this once after all states are loaded
  }

   Future<void> loadSeenStates() async {
    for (var product in _items) {
      await product.loadSeenState();
    }
    notifyListeners();  // Only call this once after all states are loaded
  }
  

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/product.json');
    final dataDecode = json.decode(response) as List;
    List<Product> data = dataDecode.map((i) => Product.fromMap(i)).toList();
    _items = data;
    await loadFavoriteStates();
    await loadSeenStates();
  }
}