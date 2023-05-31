import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';

import '../models/auth_response.dart';
import '../models/register_user_dto.dart';
import '../models/send_message.dart';
import '../models/sign_in_dto.dart';
import '../models/signable_message_dto.dart';
import '../models/user_conversation_dto.dart';
import '../models/user_conversation_message_dto.dart';
import '../models/user_dto.dart';
import '../models/user_update_dto.dart';

class ApiService {
  final String _protocol;
  final String _host;
  late Dio _dio;

  ApiService(this._protocol, this._host) {
    _dio = Dio(BaseOptions(
      baseUrl: '$_protocol://$_host',
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 5000),
    ));
    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest:
    //       (RequestOptions options, RequestInterceptorHandler handler) async {
    //     return handler.next(options);
    //   },
    //   onResponse:
    //       (Response response, ResponseInterceptorHandler handler) async {
    //     return handler.next(response);
    //   },
    //   onError: (DioError error, ErrorInterceptorHandler handler) async {
    //     if (error.response?.statusCode == 401 ||
    //         error.response?.statusCode == 403) {
    //       final RequestOptions options =
    //           error.response?.requestOptions ?? RequestOptions(path: "");
    //       final authResponse = await refresh();
    //       cookieJar.saveFromResponse(Uri(host: host, scheme: protocol), []);
    //       return dio.request(options.path, options: options).then((_) => {});
    //     }
    //     return handler.next(error);
    //   },
    // ));
    _dio.interceptors.add(CookieManager(CookieJar()));
  }

  Future<SignableMessageDto> getRegistrationMessage() async {
    final response = await _dio.get('/api/v1/user/register');
    return handleResponse<SignableMessageDto>(
        response, SignableMessageDto.fromJson)!;
  }

  Future<UserDto> register(RegisterUserDto dto) async {
    final response = await _dio.post(
      '/api/v1/user/register',
      data: dto.toJson(),
    );
    return handleResponse<UserDto>(response, UserDto.fromJson)!;
  }

  Future<void> getEmailVerificationToken() async {
    final response = await _dio.get('/api/v1/user/verify-email');
    handleResponse<void>(response);
  }

  Future<void> verifyEmail(String token) async {
    final response = await _dio.post('/api/v1/user/verify-email/$token');
    handleResponse<void>(response);
  }

  Future<SignableMessageDto> generateSignInMessage(String walletAddress) async {
    final response =
        await _dio.get('/api/v1/user/sign-in-message/$walletAddress');
    return handleResponse<SignableMessageDto>(
        response, SignableMessageDto.fromJson)!;
  }

  Future<AuthResponse> signIn(SignInDto dto) async {
    final response = await _dio.post(
      '/api/v1/user/sign-in',
      data: dto.toJson(),
    );
    return handleResponse<AuthResponse>(response, AuthResponse.fromJson)!;
  }

  Future<AuthResponse> refresh() async {
    final response = await _dio.get('/api/v1/user/refresh');
    return handleResponse<AuthResponse>(response, AuthResponse.fromJson)!;
  }

  Future<UserDto> getProfile() async {
    final response = await _dio.get('/api/v1/user/profile');
    return handleResponse<UserDto>(response, UserDto.fromJson)!;
  }

  Future<UserDto> updateProfile(UserUpdateDto dto) async {
    final response = await _dio.put(
      '/api/v1/user/profile',
      data: dto.toJson(),
    );
    return handleResponse<UserDto>(response, UserDto.fromJson)!;
  }

  Future<List<UserConversationDto>> getConversations() async {
    final response = await _dio.get('/api/v1/conversation');
    final result = handleResponse<List<UserConversationDto>>(
      response,
      (json) => (json as List)
          .map((item) => UserConversationDto.fromJson(item))
          .toList(),
    );
    return result ?? [];
  }

  Future<void> startConversation() async {
    final response = await _dio.post('/api/v1/conversation');
    handleResponse<void>(response);
  }

  Future<List<UserConversationMessageDto>> getMessages(String id) async {
    final response = await _dio.get('/api/v1/conversation/$id/messages');
    final result = handleResponse<List<UserConversationMessageDto>>(
        response,
        (json) => (json as List)
            .map((item) => UserConversationMessageDto.fromJson(item))
            .toList());
    return result ?? [];
  }

  Future<void> sendMessage(String id, SendMessageDto dto) async {
    final response = await _dio.post(
      '/api/v1/conversation/$id/messages',
      data: dto.toJson(),
    );
    handleResponse<void>(response);
  }

  Future<void> getStatus() async {
    final response = await _dio.get('/api/v1/status');
    handleResponse<void>(response);
  }

  T? handleResponse<T>(Response response,
      [T Function(Map<String, dynamic>)? fromJson]) {
    final statusCode = response.statusCode ?? -1;
    if (statusCode >= 200 && statusCode < 300) {
      if (response.data == null || response.data.toString().isEmpty) {
        throw Exception(
            'No data returned by the operation ${response.requestOptions.uri}');
      } else {
        return fromJson != null ? fromJson(response.data) : null;
      }
    } else {
      throw Exception(
          'Failed to perform operation ${response.requestOptions.uri} with status code: ${response.statusCode}');
    }
  }
}
