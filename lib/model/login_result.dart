import 'package:ecom/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_result.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResult {
  User user;
  String token;

  LoginResult(this.user, this.token);

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}
