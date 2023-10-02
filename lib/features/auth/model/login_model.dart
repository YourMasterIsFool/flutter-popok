import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends Equatable {
  LoginModel({required this.email, required this.password});

  final String email;
  final String password;
  @override
  // TODO: implement props
  List<Object?> get props => [email, password];

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
}
