class ProductDataModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String thumbnail;
  final double? discountPercentage;
  final String? brand;

  int quantity;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.thumbnail,
    this.brand,
    this.discountPercentage = 0.0,
    this.quantity = 0
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      thumbnail: json['thumbnail'],
      brand: json['brand'],
      discountPercentage: json['discountPercentage']?.toDouble(),
    );
  }
}
