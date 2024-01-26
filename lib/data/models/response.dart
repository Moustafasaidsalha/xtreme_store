import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class ResponseModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;

  const ResponseModel(this.message, this.status, this.flag);

  @override
  List<Object?> get props => [message, status, flag];

  factory ResponseModel.fromJson(Map<String, dynamic> json) => _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
