import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Product extends ChangeNotifier {
  String id;
  String categoryId;
  String title;
  String image;
  String intro;
  String ingredients;
  String instructions;
  String view;
  String favorite;
  bool isFavorite = false;
  bool isSeen = false;

  Product({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.image,
    required this.intro,
    required this.ingredients,
    required this.instructions,
    required this.view,
    required this.favorite,
  });

  void toggleIsFavorite() async {
    isFavorite = !isFavorite;
    favorite = isFavorite
        ? (int.parse(favorite) + 1).toString()
        : (int.parse(favorite) - 1).toString();
    await _saveFavoriteState();
    notifyListeners();
  }

  void handleRemoveIsFavorite() async {
    isFavorite = false;
    favorite = (int.parse(favorite) - 1).toString();
    await _saveFavoriteState();
    notifyListeners();
  }

  Future<void> _saveFavoriteState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('favorite_${id}', isFavorite);
  }

   Future<void> _saveSeenState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen${id}', isSeen);
  }



  Future<void> loadFavoriteState() async {
    final prefs = await SharedPreferences.getInstance();
    isFavorite = prefs.getBool('favorite_${id}') ?? false;
     
    notifyListeners();
  }

   Future<void> loadSeenState() async {
    final prefs = await SharedPreferences.getInstance();
    isSeen = prefs.getBool('seen${id}') ?? false;
     
    notifyListeners();
  }

  void toggleIsSeen() async {
    isSeen = true;
    await _saveSeenState();

  }

  void handleRemoveIsSeen() async {
    isSeen = false;
    _saveSeenState();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'image': image,
      'intro': intro,
      'ingredients': ingredients,
      'instructions': instructions,
      'view': view,
      'favorite': favorite,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      categoryId: map['categoryId'] as String,
      title: map['title'] as String,
      image: map['image'] as String,
      intro: map['intro'] as String,
      ingredients: map['ingredients'] as String,
      instructions: map['instructions'] as String,
      view: map['view'] as String,
      favorite: map['favorite'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
