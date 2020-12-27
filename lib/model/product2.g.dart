// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product2 _$Product2FromJson(Map<String, dynamic> json) {
  return Product2(
    json['id'] as int,
    json['name'] as String,
    json['brand'] as String,
    json['image_url'] as String,
    (json['price'] as num)?.toDouble(),
    json['expired'] == null ? null : DateTime.parse(json['expired'] as String),
    json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$Product2ToJson(Product2 instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brand': instance.brand,
      'image_url': instance.imageUrl,
      'price': instance.price,
      'expired': instance.expired?.toIso8601String(),
      'category': instance.category?.toJson(),
    };
