import 'package:ecom/model/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product2.g.dart';

@JsonSerializable(explicitToJson: true)
class Product2 {
  final int id;
  final String name;
  final String brand;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final double price;
  final DateTime expired;
  final Category category;
  Product2(this.id, this.name, this.brand, this.imageUrl, this.price,
      this.expired, this.category);

  // Deserialized function
  factory Product2.fromJson(Map<String, dynamic> json) =>
      _$Product2FromJson(json);

  // Serialized function
  Map<String, dynamic> toJson() => _$Product2ToJson(this);

  /*String formattedPrice(){
    return 'USD $price';
  }*/
  String get formattedPrice {
    return 'USD $price';
  }
}
