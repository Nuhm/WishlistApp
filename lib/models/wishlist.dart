import 'package:wishlist_app/models/wishlistItem.dart';

class Wishlist {
  final String title;
  final String description;
  final List<WishlistItem> items;

  Wishlist({
    required this.title,
    required this.description,
    required this.items,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    // Deserialize the JSON map to create a Wishlist object
    List<WishlistItem> itemList = (json['items'] as List<dynamic>)
        .map((itemJson) => WishlistItem.fromJson(itemJson))
        .toList();

    return Wishlist(
      title: json['title'],
      description: json['description'],
      items: itemList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  // Getter for the title property
  String get name => title;
}
