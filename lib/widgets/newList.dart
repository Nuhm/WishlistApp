import 'package:flutter/material.dart';
import 'package:wishlist_app/models/wishlist.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NewListPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  NewListPage({super.key});

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
            title: const Text('Error'),
            content: const Text('List name cannot be empty.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
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
            title: const Text('Error'),
            content: const Text('List name cannot contain special characters.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
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
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Create a new list',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'List name'),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'List description'),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Create a new list to group different wanted items.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => _createList(context),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, kMinInteractiveDimension),
            ), // Pass a function reference
            child: const Text('Create List'),
          ),
        ],
      ),
    );
  }
}