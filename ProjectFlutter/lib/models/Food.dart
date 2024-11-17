class Food {
  final int? id;
  final String title;
  final String description;
  final String image;
  final double rating;
  final double price;
  final bool isFavourite;
  final bool isPopular;
  final int categorieId;

  Food({
    this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
    required this.isFavourite,
    required this.isPopular,
    required this.categorieId,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString()) ?? 0.0
          : 0.0,
      price: json['price'] != null
          ? double.tryParse(json['price'].toString()) ?? 0.0
          : 0.0,
      isFavourite: json['isFavourite'] == 1,
      isPopular: json['isPopular'] == 1,
      categorieId: json['categorieId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'rating': rating,
      'price': price,
      'isFavourite': isFavourite ? 1 : 0,
      'isPopular': isPopular ? 1 : 0,
      'categorieId': categorieId,
    };
  }
}
