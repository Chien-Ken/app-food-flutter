import 'package:app_food/pages/home/Widget/Product.dart';
import 'package:app_food/pages/home/Widget/category.dart';
import 'package:app_food/pages/index.dart';
import 'package:app_food/providers/category_provider.dart';
import 'package:app_food/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()..readJson()),
       
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // home: MyApp(),
      routes: {
        '/': (context) => const MyApp(),
        '/category': (context) => const CategoryPage(),
        '/Product': (context) => const ProductPage(),
      },
    ),
  ));
}
