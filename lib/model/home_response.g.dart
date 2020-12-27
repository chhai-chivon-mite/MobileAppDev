// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) {
  return HomeResponse(
    (json['slides'] as List)?.map((e) => e as String)?.toList(),
    (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['this_week_deals'] as List)
        ?.map((e) =>
            e == null ? null : Product.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['best_sellings'] as List)
        ?.map((e) =>
            e == null ? null : Product.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'slides': instance.slides,
      'categories': instance.categories?.map((e) => e?.toJson())?.toList(),
      'this_week_deals':
          instance.thisWeekDeals?.map((e) => e?.toJson())?.toList(),
      'best_sellings': instance.bestSellings?.map((e) => e?.toJson())?.toList(),
    };
