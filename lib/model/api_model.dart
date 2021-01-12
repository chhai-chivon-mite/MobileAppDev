import 'package:json_annotation/json_annotation.dart';

part 'api_model.g.dart';

@JsonSerializable()
class ApiModel {
  bool success;
  String message;
  dynamic data;

  ApiModel(this.success, this.message, this.data);

  factory ApiModel.fromJson(Map<String, dynamic> json) =>
      _$ApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApiModelToJson(this);
}
