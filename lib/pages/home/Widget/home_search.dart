import 'package:app_food/pages/home/Widget/Search_result.dart';
import 'package:app_food/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    const snackBar = SnackBar(
  content: Text('please enter the food'),
);

    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Search key',
        enabledBorder: CustomBorder(),
        focusedBorder: CustomBorder(),
        suffixIcon: InkWell(
          onTap: () {
            if (_controller.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
          context.read<CategoryProvider>().searchCategories(context, _controller.text);
          
            }
           
          },
          child: Icon(
            Icons.search,
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder CustomBorder() => OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(12),
      );
}