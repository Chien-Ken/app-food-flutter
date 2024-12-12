import 'package:app_food/config/Constant.dart';
import 'package:app_food/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeenBody extends StatefulWidget {
  const SeenBody({Key? key}) : super(key: key);

  @override
  State<SeenBody> createState() => _SeenBodyState();
}

class _SeenBodyState extends State<SeenBody> with AutomaticKeepAliveClientMixin<SeenBody> {
    @override
  bool get wantKeepAlive => true;
   late Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = Provider.of<ProductProvider>(context, listen: false).loadSeenStates();
  }

  // @override
  // void didChangeDependencies() {
  //   _future = Provider.of<ProductProvider>(context, listen: false).loadSeenStates();
  //   super.didChangeDependencies();
  // }
  
  @override
  Widget build(BuildContext context) {
    var items = Provider.of<ProductProvider>(context).getItemsIsSeen();
    super.build(context);
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      itemBuilder: (BuildContext context, int index) {
        return ChangeNotifierProvider.value(
          value: items[index],
          child: Dismissible(
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Delete Product'),
                  content: const Text('Are You Sure Delete ?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            onDismissed: ((direction) {
              items[index].handleRemoveIsSeen();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Yay! Delete success!'),
              ));
            }),
            key: ValueKey<int>(index),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 140,
                child: GridTile(
                  footer: GridTileBar(
                    title: Text(
                      items[index].title,
                      style: styleTitleItem,
                    ),
                    trailing: const Icon(
                      Icons.swipe,
                      size: sizeIconButton,
                      color: dColorInActive,
                    ),
                    backgroundColor: Colors.white70,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(items[index].image),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
