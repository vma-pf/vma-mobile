import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:vma/core/constants/api.dart';
import 'package:vma/core/network/api_response.dart';
import 'package:vma/app/common/app_router.dart';

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
          handler.next(options);
          // AppStorage.instance
          //     .read(AppStorageKeys.token)
          //     .then((value) => {
          //           if (value != null)
          //             {options.headers['Authorization'] = 'Bearer $value'}
          //         })
          //     .whenComplete(() => handler.next(options));
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
        errorResponse.statusCode = error.response?.statusCode;
        if (error.response?.data != null &&
            error.response?.data is List<dynamic>) {
          errorResponse.message =
              (error.response?.data as List<dynamic>).elementAt(0)['content'] ??
                  'Đã có lỗi xảy ra';
        } else if (error.response?.data is Map<String, dynamic>) {
          Map<String, dynamic> errors = error.response?.data['errors'];
          dynamic errorMessages = errors.values.firstOrNull;
          errorResponse.message =
              (errorMessages as List<dynamic>).elementAtOrNull(0) as String;
        } else {
          errorResponse.message = error.response?.data;
        }
      }

      errorResponse.statusCode ??= 500;
      errorResponse.message ??= 'Hệ thống đang bận, vui lòng thử lại sau.';

      if (errorResponse.statusCode == 401 || errorResponse.statusCode == 403) {
        // AppStorage.instance.delete(AppStorageKeys.token);
        AppRouter.router.push('/login');
      }

      return Right(errorResponse);
    }
  }
}

enum ApiMethod { get, post, put, patch, delete }
