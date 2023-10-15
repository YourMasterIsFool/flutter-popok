import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel extends Equatable {
  final String? file_path;

  @JsonKey(includeToJson: false)
  final int? id;

  final String title;
  final String description;

  @JsonKey(includeToJson: false)
  final int? reader;

  @JsonKey(includeToJson: false)
  final DateTime? updated_at;

  ArticleModel(
      {this.id,
      this.file_path,
      required this.title,
      required this.description,
      this.updated_at,
      this.reader});

  @override
  List<Object?> get props => [
        this.id,
        this.file_path,
        this.title,
        this.description,
        this.updated_at,
        this.reader
      ];

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
