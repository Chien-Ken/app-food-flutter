import 'package:app_food/config/Constant.dart';
import 'package:app_food/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Product>(context, listen: false);
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      width: double.infinity,
      height: 220,
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: dColorFooter,
          title: Text(
            product.title,
            style: styleTitleItem,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<Product>(
                builder: (((context, value, child) {
                  return Row(
                    children: [
                      InkWell(
                        onTap: (() {
                          value.toggleIsFavorite();
                          print(
                              'Favorite status toggled: ${product.isFavorite}');
                        }),
                        child: Icon(
                          Icons.favorite,
                          size: sizeIconButton,
                          color: value.isFavorite ? Colors.red : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        value.favorite,
                        style: styleTitleItem,
                      ),
                    ],
                  );
                })),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.timelapse_sharp,
                size: sizeIconButton,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                product.view,
                style: styleTitleItem,
              ),
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            product.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
