import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wishlist_app/pages/wishlistPage.dart';
import 'package:wishlist_app/widgets/newList.dart';
import 'package:wishlist_app/models/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourListsPage extends StatefulWidget {
  const YourListsPage({Key? key}) : super(key: key);

  @override
  _YourListsPageState createState() => _YourListsPageState();
}

class _YourListsPageState extends State<YourListsPage> {
  List<Wishlist> _wishlists = []; // List to store fetched wishlists

  @override
  void initState() {
    super.initState();
    _loadWishlists(); // Fetch wishlists when the page is initialized
  }

  // Method to load wishlists from storage
  void _loadWishlists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList('wishlists');
    if (jsonStringList == null) return;
    List<Wishlist> wishlists = jsonStringList
        .map((jsonString) => Wishlist.fromJson(json.decode(jsonString)))
        .toList();
    setState(() {
      _wishlists = wishlists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Lists'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showCreateListBottomSheet(context);
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _wishlists.length,
        itemBuilder: (context, index) {
          Wishlist wishlist = _wishlists[index];
          return Dismissible(
            key: Key(wishlist.name), // Unique key for each list item
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              // Show a confirmation dialog before deletion
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text("Are you sure you want to delete this list?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("CANCEL"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("DELETE"),
                      ),
                    ],
                  );
                },
              );
            },
            onDismissed: (direction) {
              // Remove the list item from the list
              setState(() {
                _wishlists.removeAt(index);
              });
              // Update SharedPreferences to reflect the change
              _updateWishlistsInSharedPreferences();
            },
            child: ListTile(
              title: Text(wishlist.name),
              subtitle: Text(wishlist.description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WishlistPage(wishlist: wishlist),
                  ),
                );
              },
            ),
          );
        },
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

  void _updateWishlistsInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList = _wishlists.map((wishlist) => json.encode(wishlist.toJson())).toList();
    prefs.setStringList('wishlists', jsonStringList);
  }
}
