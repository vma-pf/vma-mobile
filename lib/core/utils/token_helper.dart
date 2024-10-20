import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHelper {
  static String getRole(String token) {
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['role'];
  }
}
