import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:vma/core/constants/api.dart';
import 'package:vma/core/enums/app_storage_keys.dart';
import 'package:vma/core/network/api_response.dart';
import 'package:vma/app/common/app_router.dart';
import 'package:vma/core/network/app_storage.dart';

class ApiCaller {
  final Dio _dio = Dio(_baseOptions);
  static final ApiCaller instance = ApiCaller._();

  static final _baseOptions = BaseOptions(
    baseUrl: Api.baseApiUrl,
    connectTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
  );

  ApiCaller._() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          AppStorage.read(AppStorageKeys.token)
              .then(
                (value) => {
                  if (value != null)
                    {options.headers['Authorization'] = 'Bearer $value'},
                },
              )
              .whenComplete(() => handler.next(options));
        },
      ),
    );
  }

  Future<Response> _callDio({
    required ApiMethod method,
    required String path,
    Map<String, dynamic>? queryParams,
    dynamic data,
  }) async {
    switch (method) {
      case ApiMethod.get:
        return await _dio.get(path, queryParameters: queryParams);
      case ApiMethod.post:
        return _dio.post(path, queryParameters: queryParams, data: data);
      case ApiMethod.put:
        return _dio.put(path, queryParameters: queryParams, data: data);
      case ApiMethod.patch:
        return _dio.patch(path, queryParameters: queryParams, data: data);
      case ApiMethod.delete:
        return _dio.delete(path, queryParameters: queryParams, data: data);
      default:
        throw ArgumentError('Api method \'$method\' is not supported.');
    }
  }

  Future<Either<ApiSuccessResponse, ApiErrorResponse>> request({
    required ApiMethod method,
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    dynamic data,
  }) async {
    try {
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      final response = await _callDio(
        method: method,
        path: path,
        queryParams: queryParams,
        data: data,
      );

      final successResponse = ApiSuccessResponse.fromJson(response.data);

      return Left(successResponse);
    } catch (error) {
      final errorResponse = ApiErrorResponse();

      if (error is DioException) {
        final dynamic errorData = error.response?.data;
        if (errorData != null && errorData is Map<String, dynamic>) {
          errorResponse.message =
              errorData['errorMessage'] ?? 'Đã có lỗi xảy ra';
        }

        final int statusCode = error.response?.statusCode ?? -1;
        // redirect to login page if token is invalid
        if (statusCode == 401 || statusCode == 403) {
          AppStorage.read(AppStorageKeys.token).then((value) {
            if (value != null) {
              AppStorage.delete(AppStorageKeys.token);
              AppRouter.router.push('/login');
            }
          });
        }
      }

      errorResponse.message ??= 'Hệ thống đang bận, vui lòng thử lại sau.';

      return Right(errorResponse);
    }
  }
}

enum ApiMethod { get, post, put, patch, delete }
