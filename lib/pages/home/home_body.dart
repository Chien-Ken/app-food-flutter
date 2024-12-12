import 'package:app_food/config/Constant.dart';
import 'package:app_food/pages/home/Widget/User_Manage/DeleteButton.dart';
import 'package:app_food/pages/home/Widget/home_search.dart';
import 'package:app_food/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}


class _HomeBodyState extends State<HomeBody> with AutomaticKeepAliveClientMixin  {
   @override
  bool get wantKeepAlive => true;
 

  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  Provider.of<CategoryProvider>(context, listen: false).readJson();
}

  @override
  Widget build(BuildContext context) {
     super.build(context); 
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        var categoryItems = categoryProvider.items;

        if (categoryItems.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const HomeSearch(),
              const SizedBox(height: 10),
             
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: categoryItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/category',
                          arguments: {
                            'title': categoryItems[index].name,
                            'categoryId': categoryItems[index].id,
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      categoryItems[index].image),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                               
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      categoryItems[index].name,
                                      style: styleTitleItem,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              
                                Expanded(
                                  child: DeleteButton(index: index)
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
