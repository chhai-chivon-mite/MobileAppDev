import 'package:ecom/model/category.dart';
import 'package:ecom/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeResponse {
  List<String> slides;
  List<Category> categories;
  @JsonKey(name: 'this_week_deals')
  List<Product> thisWeekDeals;
  @JsonKey(name: 'best_sellings')
  List<Product> bestSellings;

  // Constructor
  HomeResponse(
      this.slides, this.categories, this.thisWeekDeals, this.bestSellings);

  // Deserialzied function
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  // Serialized function
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}
