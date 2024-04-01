import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wishlist_app/pages/wishlistPage.dart';
import 'package:wishlist_app/widgets/newList.dart';
import 'package:wishlist_app/models/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourListsPage extends StatefulWidget {
  const YourListsPage({super.key});

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
    print(jsonStringList);
    List<Wishlist> wishlists = jsonStringList
        .map((jsonString) => Wishlist.fromJson(json.decode(jsonString)))
        .toList();
    setState(() {
      _wishlists = wishlists;
    });
    }

  // Method to parse JSON string to Wishlist objects
  List<Wishlist> _parseWishlists(String jsonString) {
    Iterable decodedList = json.decode(jsonString);
    List<Wishlist> wishlists = decodedList.map((json) => Wishlist.fromJson(json)).toList();
    return wishlists;
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
          return ListTile(
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
}
