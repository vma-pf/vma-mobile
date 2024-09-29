class ApiErrorResponse {
  int? statusCode;
  String? message;
}

class ApiSuccessResponse<T> {
  bool isSuccess;
  T? data;
  String? errorMessage;

  ApiSuccessResponse({required this.isSuccess, this.data, this.errorMessage});

  factory ApiSuccessResponse.fromJson(Map<String, dynamic> json) {
    return ApiSuccessResponse(
      isSuccess: json['isSuccess'],
      data: json['data'],
      errorMessage: json['errorMessage'],
    );
  }
}
