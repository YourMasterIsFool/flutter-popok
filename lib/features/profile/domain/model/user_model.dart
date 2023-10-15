import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  UserModel(
      {this.id,
      required this.email,
      this.password,
      required this.role_id,
      this.role_name,
      required this.name});

  @JsonKey(includeToJson: false)
  final int? id;

  @JsonKey(includeFromJson: true, includeToJson: false)
  final String? role_name;
  final String email;
  final String name;

  final int role_id;

  @JsonKey(includeFromJson: false, includeToJson: true)
  final String? password;

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.email,
        this.name,
        this.role_name,
        this.id,
        this.password,
        this.role_id
      ];

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
