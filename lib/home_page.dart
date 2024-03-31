import 'package:flutter/material.dart';
import 'new_list_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showCreateListBottomSheet(context);
              },
              child: Text('Create New List'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateListBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return NewListPage(); // Display NewListPage as the bottom sheet
      },
    );
  }
}
