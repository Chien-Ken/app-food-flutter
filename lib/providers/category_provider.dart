import 'dart:convert';

import 'package:app_food/models/category.dart';
import 'package:app_food/pages/home/Widget/Search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _items = [];

  List<Category> get items => [..._items];

  List<Category> searchResults = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/category.json');
    final List<dynamic> dataDecode = json.decode(response);
    _items = dataDecode.map((i) => Category.fromJson(jsonEncode(i))).toList();
    notifyListeners();
  }

  void searchCategories(BuildContext context, String query) {
    searchResults = _items
        .where((category) =>
            category.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  SearchResult()),
    );
    notifyListeners();
  }

  

  void deleteItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
