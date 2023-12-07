import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pos_flutter/features/profile/domain/model/user_model.dart';

part 'pelatihan_member.g.dart';

@JsonSerializable()
class PelatihanMember extends Equatable {
  final int pelatihan_id;

  @JsonKey(includeFromJson: true, includeToJson: false)
  final int? id;
  final int customer_id;

  final int? acc;

  final UserModel? customer;

  PelatihanMember({
    this.id,
    required this.pelatihan_id,
    required this.customer_id,
    this.customer,
    required this.acc,
  });
  @override
  // TODO: implement props
  List<Object?> get props =>
      [this.pelatihan_id, this.customer, this.id, this.customer_id, this.acc];

  factory PelatihanMember.fromJson(Map<String, dynamic> json) =>
      _$PelatihanMemberFromJson(json);
}
