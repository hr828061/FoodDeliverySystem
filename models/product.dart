class Product {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final String description;

  Product({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'imageUrl': imageUrl,
        'price': price,
        'description': description,
      };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      description: json['description'],
    );
  }
}
