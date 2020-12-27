class Product {
  final int id;
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  Product(this.id, this.name, this.brand, this.imageUrl, this.price);

  // Deserialized function
  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        brand = json['brand'],
        imageUrl = json['imageUrl'],
        price = (json['price'] as num)?.toDouble();

  // Serialized function
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'imageUrl': imageUrl,
      'price': price
    };
  }

  /*String formattedPrice(){
    return 'USD $price';
  }*/
  String get formattedPrice {
    return 'USD $price';
  }
}
