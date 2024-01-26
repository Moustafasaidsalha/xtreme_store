import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse extends Equatable {
  @JsonKey(name: "flag")
  final bool? flag;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "message")
  final String? message;

  const AuthResponse({
    this.flag,
    this.status,
    this.message,
  });

  @override
  List<Object?> get props => [
        flag,
        status,
        message,
      ];

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
