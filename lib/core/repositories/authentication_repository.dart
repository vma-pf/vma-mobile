import 'package:vma/core/models/authentication_response.dart';
import 'package:vma/core/network/api.dart';

class AuthenticationRepository {
  Future<AuthenticationResponse?> login({
    required String username,
    required String password,
  }) async {
    final payload = {
      'username': username,
      'password': password,
    };

    final response = await ApiCaller.instance.request(
      path: '/api/auth/login',
      method: ApiMethod.post,
      data: payload,
    );

    AuthenticationResponse? authResponse;

    response.either((success) {
      authResponse = AuthenticationResponse.fromJson(success.data);
    }, (error) {
      // TODO: handle error
    });

    return Future.value(authResponse);
  }
}
