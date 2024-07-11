class AuthResponse {
  AuthResponse({
    required this.result,
    required this.accessToken,
    required this.message,
    required this.status,
    required this.success,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken:
          (json['result'] as Map<String, dynamic>)['access_token'] as String,
      result: json['result'] as Map<String, dynamic>? ?? <String, dynamic>{},
      message: json['message'] as String,
      status: json['status'] as int,
      success: json['success'] as bool,
    );
  }
  final String accessToken;
  final Map<String, dynamic> result;
  final String message;
  final int status;
  final bool success;

  @override
  String toString() {
    return 'AuthResponse(accessToken: $accessToken, message: $message, status: $status, success: $success)';
  }
}
