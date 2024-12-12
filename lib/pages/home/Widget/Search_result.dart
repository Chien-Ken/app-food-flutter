import 'package:app_food/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filteredItems = context.watch<CategoryProvider>().searchResults;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: filteredItems.isNotEmpty
          ? ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return ListTile(
                  title: Container(
                    alignment: Alignment.center,
                    child: Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      
                    ),
                  ),
                  subtitle: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text('No item found'),
            ),
    );
  }
}
