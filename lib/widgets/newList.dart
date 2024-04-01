import 'package:flutter/material.dart';
import 'package:wishlist_app/models/wishlist.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NewListPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Validation method to create the list
  void _createList(context) {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();
    RegExp regExp = RegExp(r'[^\w\s]+');

    if (title.isEmpty) {
      // Show an error if the title is empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('List name cannot be empty.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (regExp.hasMatch(title)) {
      // Show an error if the title contains special characters
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('List name cannot contain special characters.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Proceed with creating the list
      Wishlist wishlist = Wishlist(
        title: title,
        description: '', // Add a description if necessary
        items: [], // Add items if necessary
      );
      String jsonWishlist = json.encode(wishlist.toJson());
      // Store the JSON string in SharedPreferences
      SharedPreferences.getInstance().then((prefs) {
        List<String> existingWishlists = prefs.getStringList('wishlists') ?? [];
        existingWishlists.add(jsonWishlist);
        prefs.setStringList('wishlists', existingWishlists);
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Create a new list',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'List name'),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'List description'),
          ),
          SizedBox(height: 20.0),
          Text(
            'Create a new list to group different wanted items.',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => _createList(context), // Pass a function reference
            child: Text('Create List'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, kMinInteractiveDimension),
            ),
          ),
        ],
      ),
    );
  }
}