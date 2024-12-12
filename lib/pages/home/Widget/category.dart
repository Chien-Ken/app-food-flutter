import 'package:app_food/config/Constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_food/providers/product_provider.dart';
import 'package:app_food/models/product.dart';
import 'package:app_food/pages/home/Widget/category_body.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context)?.settings.arguments as Map?;
    final String? categoryId = params?['categoryId'];
    final String? title = params?['title'];

    if (categoryId == null || title == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Category'),
          backgroundColor: dColorMain,
        ),
        body: const Center(child: Text('Invalid category data')),
      );
    }

    var products = Provider.of<ProductProvider>(context)
        .getItemsWithCategoryId(categoryId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: dColorMain,
        title: Text(
          title,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: products.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 20);
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (() {
              Navigator.pushNamed(context, '/Product',
                  arguments: {"id": products[index].id});
            }),
            child: ChangeNotifierProvider<Product>.value(
              value: products[index],
              child: const CategoryBody(),
            ),
          );
        },
      ),
    );
  }
}
