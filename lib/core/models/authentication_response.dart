class AuthenticationResponse {
  final String userId;
  final String userName;
  final String email;
  final String accessToken;
  final String refreshToken;

  AuthenticationResponse({
    required this.userId,
    required this.userName,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
