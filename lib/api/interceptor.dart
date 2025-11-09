import 'package:dio/dio.dart';

import 'package:find_neighbour_v001/storage/session.dart';

class RefreshTokenInterceptor extends Interceptor {
  final Dio _dio;
  final Future<void> Function() _refreshTokenCallback;
  final Future<void> Function()? _onTokenRefreshFailed;

  bool _isRefreshing = false;
  final List<RequestOptions> _requestsQueue = [];

  RefreshTokenInterceptor({
    required Dio dio,
    required Future<void> Function() refreshTokenCallback,
    Future<void> Function()? onTokenRefreshFailed,
  })  : _dio = dio,
        _refreshTokenCallback = refreshTokenCallback,
        _onTokenRefreshFailed = onTokenRefreshFailed;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRefreshToken(err)) {
      _requestsQueue.add(err.requestOptions);

      if (!_isRefreshing) {
        _isRefreshing = true;

        try {
          await _refreshTokenCallback();
          await _retryRequests();
        } catch (e) {
          await _onTokenRefreshFailed?.call();

          _clearQueue();
          handler.reject(err);
          TemporaryStorage.clear();
        } finally {
          _isRefreshing = false;
        }
      } else {
        handler.reject(err);
        TemporaryStorage.clear();
      }
    } else {
      TemporaryStorage.clear();
      handler.reject(err);
    }
  }

  bool _shouldRefreshToken(DioException err) {
    return err.response?.statusCode == 401 &&
        err.type != DioExceptionType.cancel;
  }

  Future<void> _retryRequests() async {
    final queue = List<RequestOptions>.from(_requestsQueue);
    _requestsQueue.clear();

    for (final options in queue) {
      try {
        await _dio.request(
          options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          options: Options(
            method: options.method,
            headers: options.headers,
          ),
        );
      } catch (e) {
        print('Failed to retry request: ${options.path}');
      }
    }
  }

  void _clearQueue() {
    _requestsQueue.clear();
  }
}
