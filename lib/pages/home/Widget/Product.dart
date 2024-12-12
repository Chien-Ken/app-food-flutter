import 'package:app_food/config/Constant.dart';
import 'package:app_food/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final String? productId = args?['id'];
    bool change = true;

    if (productId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Product'),
          backgroundColor: dColorMain,
        ),
        body: const Center(child: Text('Invalid product data')),
      );
    }

    var item = Provider.of<ProductProvider>(context).getItemWithId(productId);
    item.toggleIsSeen();

    // Print statement to check item once

    return Scaffold(
      appBar: AppBar(
        title: Text(args?['title'] ?? 'Product Page'),
        backgroundColor: dColorMain,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(item.image),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    width: 120,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(12)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            item.toggleIsFavorite();
                            setState(() {
                              change = !change;
                            });
                          },
                          child: Icon(
                            Icons.favorite,
                            color: item.isFavorite ? Colors.red : Colors.white,
                            size: sizeIconButton,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          item.favorite,
                          style: styleTitleItem,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 120,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(12)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.view_agenda,
                          color: dColorInActive,
                          size: sizeIconButton,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          item.view,
                          style: styleTitleItem,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    item.title,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 167,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: const Center(
                          child: Text(
                            'Ingredients',
                            style: styleTitleItem,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Text(
                          item.ingredients,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 167,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: const Center(
                          child: Text(
                            'Implementation',
                            style: styleTitleItem,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Text(
                          item.instructions,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
