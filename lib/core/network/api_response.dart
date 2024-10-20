class ApiErrorResponse {
  String? message;

  ApiErrorResponse({this.message});

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      message: json['errorMessage'],
    );
  }
}

class ApiSuccessResponse<T> {
  T? data;

  ApiSuccessResponse({this.data});

  factory ApiSuccessResponse.fromJson(Map<String, dynamic> json) {
    return ApiSuccessResponse(
      data: json['data'],
    );
  }
}
