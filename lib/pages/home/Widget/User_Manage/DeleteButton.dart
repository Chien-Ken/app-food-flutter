import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_food/providers/category_provider.dart';

class DeleteButton extends StatelessWidget {
  final int index;

  const DeleteButton({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showDialogFun(context);
      },
      child: const Text('Delete'),
    );
  }

  void _showDialogFun (BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dialog title'),
          content: const Text(
            'Are you sure to delete.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                 Provider.of<CategoryProvider>(context, listen: false).deleteItem(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
}

}
