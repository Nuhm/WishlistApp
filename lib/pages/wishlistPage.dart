import 'package:flutter/material.dart';
import 'package:wishlist_app/models/wishlist.dart';

class WishlistPage extends StatelessWidget {
  final Wishlist wishlist;

  const WishlistPage({super.key, required this.wishlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wishlist.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(wishlist.description),
            const SizedBox(height: 16),
            const Text(
              'Items:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: wishlist.items.length,
                itemBuilder: (context, index) {
                  final item = wishlist.items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.description),
                    leading: Image.network(item.imageURL), // Display item image
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
