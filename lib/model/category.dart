import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String name;
  Category(this.id, this.name);

  // Deserialized function
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  // Serialized function
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
