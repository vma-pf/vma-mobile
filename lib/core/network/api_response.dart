class ApiErrorResponse {
  int? statusCode;
  String? message;
}

class ApiSuccessResponse<T> {
  int? statusCode;
  String? message;
  T? data;

  ApiSuccessResponse({this.data, this.statusCode, this.message});
}
