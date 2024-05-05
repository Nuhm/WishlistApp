import 'package:flutter/material.dart';
import 'package:wishlist_app/models/wishlist.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NewListPage extends StatefulWidget {
  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Create a new list'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Text(
            'Create a new list',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'List name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'List description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onEditingComplete: () {
              // Dismiss the keyboard when the user taps "Done"
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
          SizedBox(height: 20.0),
          Text(
            'Create a new list to group different wanted items.',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => _createList(context),
            child: Text('Create List'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, kMinInteractiveDimension),
            ),
          ),
        ],
      ),
    );
  }

  void _createList(BuildContext context) {
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
        description: description,
        items: [],
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
}