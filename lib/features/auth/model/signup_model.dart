import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'signup_model.g.dart';

@JsonSerializable()
class SignupModel extends Equatable {
  SignupModel(
      {required this.email, required this.name, required this.password});

  final String email;
  final String name;
  final String password;
  @override
  // TODO: implement props
  List<Object?> get props => [email, this.password, this.name];

  Map<String, dynamic> toJson() => _$SignupModelToJson(this);
  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);
}
