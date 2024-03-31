import 'package:flutter/material.dart';
import 'new_list_page.dart';

class YourListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Lists'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0), // Adjust the right padding as needed
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _showCreateListBottomSheet(context);
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('Your Lists Page'),
      ),
    );
  }

  void _showCreateListBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return NewListPage();
      },
    );
  }
}
