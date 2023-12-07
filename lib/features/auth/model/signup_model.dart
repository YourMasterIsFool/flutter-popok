import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'signup_model.g.dart';

@JsonSerializable()
class SignupModel extends Equatable {
  SignupModel(
      {required this.email,
      this.alamat,
      this.jenis_kelamin,
      this.phone_number,
      required this.name,
      required this.question_id,
      required this.question_answer,
      required this.password});

  final String email;
  final String name;

  final String? alamat;
  final String? jenis_kelamin;
  final String? phone_number;
  final String? password;

  final int question_id;
  final String question_answer;
  @override
  // TODO: implement props
  List<Object?> get props => [email, this.password, this.name];

  Map<String, dynamic> toJson() => _$SignupModelToJson(this);
  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);
}
