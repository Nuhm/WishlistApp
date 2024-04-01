class WishlistItem {
  final String name;
  final String description;
  final String imageURL;

  WishlistItem({
    required this.name,
    required this.description,
    required this.imageURL,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      name: json['name'],
      description: json['description'],
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageURL': imageURL,
    };
  }
}
