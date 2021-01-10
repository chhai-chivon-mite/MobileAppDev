import 'package:ecom/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_result.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResult {
  bool success;
  String message;
  @JsonKey(name: 'data')
  User user;

  LoginResult(this.success, this.message, this.user);

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}
