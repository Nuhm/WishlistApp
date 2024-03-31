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
            const Text(
              'Welcome to the Home Page!',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to NewListPage to create a new list
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewListPage()),
                );
              },
              child: const Text('Create New List'),
            ),
          ],
        ),
      ),
    );
  }
}
