import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'donasi_status_model.g.dart';

@JsonSerializable()
class DonasiStatusModel extends Equatable {
  final int code;
  final String status;

  DonasiStatusModel({required this.code, required this.status});

  @override
  // TODO: implement props
  List<Object?> get props => [this.code, this.status];

  factory DonasiStatusModel.fromJson(Map<String, dynamic> json) =>
      _$DonasiStatusModelFromJson(json);
}
