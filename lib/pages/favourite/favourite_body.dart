import 'package:app_food/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteBody extends StatefulWidget {
  const FavouriteBody({Key? key}) : super(key: key);

  @override
  _FavouriteBodyState createState() => _FavouriteBodyState();
}

class _FavouriteBodyState extends State<FavouriteBody> with AutomaticKeepAliveClientMixin<FavouriteBody> {
  @override
  bool get wantKeepAlive => true;
  
  late Future<void> _loadFavoriteFuture;

  @override
  void initState() {
    super.initState();
    _loadFavoriteFuture = _initializeFuture();
  }

  Future<void> _initializeFuture() async {
    return Provider.of<ProductProvider>(context, listen: false).loadFavoriteStates();
  }

  @override
  Widget build(BuildContext context) {
     super.build(context);
    return FutureBuilder<void>(
      future: _loadFavoriteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              var items = productProvider.getItemsIsFavorite();
              if (items.isEmpty) {
                return const Center(child: Text('No favorite items found'));
              }
              return ListView.separated(
                itemCount: items.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: ValueKey<int>(index),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Confirm Delete'),
                          content: const Text('Do you want to delete this item?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    onDismissed: (direction) {
                      items[index].handleRemoveIsFavorite();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Deleted successfully')),
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 140,
                      child: GridTile(
                        footer: GridTileBar(
                          title: Text(
                            items[index].title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.white70,
                          trailing: const Icon(
                            Icons.swap_calls,
                            size: 24,
                            color: Colors.grey,
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(items[index].image),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
