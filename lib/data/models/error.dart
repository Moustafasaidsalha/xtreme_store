import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';
part 'error.g.dart';

@JsonSerializable()
class ErrorMessageModel extends Equatable{
  final int status;
  final String message;
  final  bool flag;


const  ErrorMessageModel(this.status, this.message, this.flag);

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorMessageModelToJson(this);
  @override
  List<Object?> get props => [status,message,flag];

//






}