import 'package:flutter_node_mongo/data/user_request.dart';
import 'package:flutter_node_mongo/data/user_response.dart';

abstract class AuthService {
  Future<UserResponse> login({required UserRequest request});
}
