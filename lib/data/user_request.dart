import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_node_mongo/data/user.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest {
  final User user;
  UserRequest({
    required this.user,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}
