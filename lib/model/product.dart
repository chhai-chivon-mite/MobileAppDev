class Product {
  final int id;
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  Product(this.id, this.name, this.brand, this.imageUrl, this.price);

  /*String formattedPrice(){
    return 'USD $price';
  }*/
  String get formattedPrice {
    return 'USD $price';
  }
}
