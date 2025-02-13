import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:ai_store/common/widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:ai_store/network/response/api_response.dart';
import 'package:ai_store/screens/authentication/sign_in/controller/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  final SignInController signInController = Get.put(SignInController());
  static const Duration timeoutDuration = Duration(seconds: 30);
  final SharedPreferences prefs;
  final bool isDebug;

  NetworkService({required this.prefs, this.isDebug = true});

  Future<String?> get _token async => prefs.getString('token');

  void _logDebug(String message) {
    if (isDebug) {
      developer.log(message, name: 'NetworkService');
    }
  }

  Map<String, String> _headers(String token) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return headers;
  }

  Map<String, String> get _baseHeaders {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return headers;
  }

  Future<ApiResponse<Map<String, dynamic>>> get(
    String url,
  ) async {
    try {
      _logDebug('GET Request URL: $url');

      final token = await _token;
      _logDebug('Token: $token');

      if (token == null) {
        return ApiResponse.error('Authentication token not found');
      }

      final response = await http
          .get(Uri.parse(url), headers: _headers(token))
          .timeout(timeoutDuration);

      return _handleRawResponse(response);
    } on SocketException {
      _logDebug('GET SocketException: No internet connection');
      return ApiResponse.error('No internet connection');
    } on TimeoutException {
      _logDebug('GET TimeoutException: Request timed out');
      return ApiResponse.error('Request timed out');
    } catch (e) {
      _logDebug('GET Exception: ${e.toString()}');
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> post(
    String url,
    dynamic data, {
    bool requiresAuth = true,
  }) async {
    try {
      _logDebug('POST Request URL: $url');
      _logDebug('POST Request Body: $data');

      final token = requiresAuth ? await _token : null;
      final headers = requiresAuth ? _headers(token ?? '') : _baseHeaders;

      final response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(data),
          )
          .timeout(timeoutDuration);

      _logDebug('POST Response Body: ${response.body}');

      return _handleRawResponse(response);
    } on SocketException {
      _logDebug('POST SocketException: No internet connection');
      return ApiResponse.error('No internet connection');
    } on TimeoutException {
      _logDebug('POST TimeoutException: Request timed out');
      return ApiResponse.error('Request timed out');
    } catch (e) {
      _logDebug('POST Exception: ${e.toString()}');
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> delete(
    String url,
  ) async {
    try {
      _logDebug('DELETE Request URL: $url');

      final token = await _token;
      _logDebug('Token: $token');

      if (token == null) {
        return ApiResponse.error('Authentication token not found');
      }

      final response = await http
          .delete(Uri.parse(url), headers: _headers(token))
          .timeout(timeoutDuration);

      _logDebug('DELETE Response Body: ${response.body}');

      return _handleRawResponse(response);
    } on SocketException {
      _logDebug('DELETE SocketException: No internet connection');
      return ApiResponse.error('No internet connection');
    } on TimeoutException {
      _logDebug('DELETE TimeoutException: Request timed out');
      return ApiResponse.error('Request timed out');
    } catch (e) {
      _logDebug('DELETE Exception: ${e.toString()}');
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> postMultipart({
    required String url,
    required Map<String, String> fields,
    required String filePath,
    required String fileField,
  }) async {
    try {
      _logDebug('POST Multipart Request URL: $url');
      _logDebug('POST Multipart Fields: $fields');
      _logDebug('POST Multipart File Path: $filePath');

      final token = await _token;
      if (token == null) {
        return ApiResponse.error('Authentication token not found');
      }

      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(_headers(token));

      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      final file = File(filePath);
      if (file.existsSync()) {
        final fileStream = http.ByteStream(file.openRead());
        final fileLength = await file.length();
        final multipartFile = http.MultipartFile(
          fileField,
          fileStream,
          fileLength,
          filename: file.path.split('/').last,
        );
        request.files.add(multipartFile);
      } else {
        _logDebug('File does not exist at path: $filePath');
      }

      final streamedResponse = await request.send().timeout(timeoutDuration);
      final response = await http.Response.fromStream(streamedResponse);

      _logDebug('POST Multipart Response Status: ${response.statusCode}');
      _logDebug('POST Multipart Response Body: ${response.body}');

      return _handleRawResponse(response);
    } on SocketException {
      _logDebug('POST Multipart SocketException: No internet connection');
      return ApiResponse.error('No internet connection');
    } on TimeoutException {
      _logDebug('POST Multipart TimeoutException: Request timed out');
      return ApiResponse.error('Request timed out');
    } catch (e) {
      _logDebug('POST Multipart Exception: ${e.toString()}');
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> authGet(String url) async {
    try {
      _logDebug('Auth GET Request URL: $url');

      final response = await http
          .get(Uri.parse(url), headers: _baseHeaders)
          .timeout(timeoutDuration);

      return _handleRawResponse(response);
    } on SocketException {
      _logDebug('Auth GET SocketException: No internet connection');
      return ApiResponse.error('No internet connection');
    } on TimeoutException {
      _logDebug('Auth GET TimeoutException: Request timed out');
      return ApiResponse.error('Request timed out');
    } catch (e) {
      _logDebug('Auth GET Exception: ${e.toString()}');
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> authPost(
    String url,
    dynamic data,
  ) async {
    try {
      _logDebug('Auth POST Request URL: $url');
      _logDebug('Auth POST Request Body: $data');

      final response = await http
          .post(
            Uri.parse(url),
            headers: _baseHeaders,
            body: jsonEncode(data),
          )
          .timeout(timeoutDuration);

      return _handleRawResponse(response);
    } on SocketException {
      _logDebug('Auth POST SocketException: No internet connection');
      return ApiResponse.error('No internet connection');
    } on TimeoutException {
      _logDebug('Auth POST TimeoutException: Request timed out');
      return ApiResponse.error('Request timed out');
    } catch (e) {
      _logDebug('Auth POST Exception: ${e.toString()}');
      return ApiResponse.error(e.toString());
    }
  }

  ApiResponse<Map<String, dynamic>> _handleRawResponse(
    http.Response response,
  ) {
    _logDebug('Handling Response - Status Code: ${response.statusCode}');

    switch (response.statusCode) {
      case 200:
      case 201:
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return ApiResponse.completed(jsonData);
      case 401:
        _logDebug('Unauthorized Access');
        _handleUnauthorized();
        return ApiResponse.error('Unauthorized access');
      case 500:
        _logDebug('Server Error');
        return ApiResponse.error('Server error');
      default:
        _logDebug('Unknown Error: ${response.statusCode}');
        return ApiResponse.error(
          'Error occurred: ${response.statusCode}',
        );
    }
  }

  void _handleUnauthorized() {
    _logDebug('Handling Unauthorized Access');
    if (Get.context != null) {
      showDialog(
        context: Get.context!,
        builder: (context) => CustomAlertDialog(
          title: "Unauthorized",
          subTitle:
              "You are not authorized to access this resource. Please log in again!",
          okButtonName: "OK",
          pressedOk: () {
            signInController.signOut();
          },
        ),
      );
    }
  }
}
