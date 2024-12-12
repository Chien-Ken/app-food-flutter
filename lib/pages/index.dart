import 'package:app_food/config/Constant.dart';
import 'package:app_food/pages/favourite/favourite_body.dart';
import 'package:app_food/pages/home/home_body.dart';
import 'package:app_food/pages/seen/seen_body.dart';
import 'package:app_food/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load data once during initialization
    Provider.of<ProductProvider>(context, listen: false).readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Good Food'),
        backgroundColor: dColorMain,
      ),
      body: _buildPage(currentPageIndex),
      bottomNavigationBar: NavigationBar(
        backgroundColor: dColorMain,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              size: sizeIconButton,
              color: dColorActive,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: dColorInActive,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.favorite,
              size: sizeIconButton,
              color: dColorActive,
            ),
            icon: Icon(
              Icons.favorite,
              color: dColorInActive,
            ),
            label: 'Favourite',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.view_agenda,
              size: sizeIconButton,
              color: dColorActive,
            ),
            icon: Icon(
              Icons.view_agenda,
              color: dColorInActive,
            ),
            label: 'Seen',
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomeBody();

      case 1:
        return const FavouriteBody();

      case 2:
        return const SeenBody();
      default:
        return const Center(
          child: Text('Page not found'),
        );
    }
  }
}


