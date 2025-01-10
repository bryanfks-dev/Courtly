import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/config/api_server_config.dart';
import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/repository/local/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [ApiRepository] is a repository to handle API requests.
/// This class is used to make API requests to the server.
class ApiRepository {
  /// [_apiUrl] is the base URL of the API server.
  /// This URL is used to make the API request.
  static const String _apiUrl =
      "${ApiServerConfig.baseUrl}/api/${ApiServerConfig.version}";

  /// [_token] is the JWT token for the API request.
  /// This JWT token is used to authenticate the API request.
  String? _token;

  /// [_headers] is the headers for the API request.
  /// This headers is used to set the headers for the API request.
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// [setTokenFromStorage] is a function to set the JWT token from the storage.
  Future<void> setTokenFromStorage(
      {required TokenRepository tokenRepository}) async {
    // Get the token from the repository
    final String? token = await tokenRepository.getToken();

    // Check if the token is null
    if (token == null) {
      return;
    }

    _token = token;
  }

  /// [get] is a function to make a GET request to the API.
  /// This function will make a GET request to the API with the given endpoint.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [http.Response].
  Future<Either<Failure, http.Response>> get(
      {required String endpoint,
      required int timeoutInSec,
      Map<String, dynamic>? queryParam}) async {
    /// [uri] is the URI for the API request.
    late Uri uri;

    // Check if the query parameters is null or empty
    if (queryParam == null || queryParam.isEmpty) {
      uri = Uri.parse('$_apiUrl/$endpoint');
    } else {
      uri =
          Uri.parse('$_apiUrl/$endpoint').replace(queryParameters: queryParam);
    }

    try {
      /// Make a GET request to the API.
      final res = await http.get(uri, headers: {
        ..._headers,
        if (_token != null) 'Authorization': 'Bearer $_token',
      }).timeout(Duration(seconds: timeoutInSec));

      return right(res);
    } on SocketException catch (_) {
      return left(const NetworkFailure());
    } on HttpException catch (_) {
      return left(const RequestFailure("Cannot reach the server"));
    } on TimeoutException catch (_) {
      return left(const RequestFailure());
    } on Exception catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  /// [post] is a function to make a POST request to the API.
  /// This function will make a POST request to the API with the given endpoint.
  /// The [body] parameter is the data that will be sent to the API.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [http.Response].
  Future<Either<Failure, http.Response>> post(
      {required String endpoint,
      Map<String, dynamic>? body,
      required int timeoutInSec}) async {
    try {
      /// Make a POST request to the API.
      final res = await http
          .post(Uri.parse('$_apiUrl/$endpoint'),
              headers: {
                ..._headers,
                if (_token != null) 'Authorization': 'Bearer $_token',
              },
              body: json.encode(body))
          .timeout(Duration(seconds: timeoutInSec));

      return right(res);
    } on SocketException catch (_) {
      return left(const NetworkFailure());
    } on HttpException catch (_) {
      return left(const RequestFailure("Cannot reach the server"));
    } on TimeoutException catch (_) {
      return left(const RequestFailure());
    } on Exception catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  /// [patch] is a function to make a PATCH request to the API.
  /// This function will make a PATCH request to the API with the given endpoint.
  /// The [body] parameter is the data that will be sent to the API.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [http.Response].
  Future<Either<Failure, http.Response>> patch(
      {required String endpoint,
      required Map<String, dynamic> body,
      required int timeoutInSec}) async {
    try {
      /// Make a PATCH request to the API.
      final res = await http
          .patch(Uri.parse('$_apiUrl/$endpoint'),
              headers: {
                ..._headers,
                if (_token != null) 'Authorization': 'Bearer $_token',
              },
              body: json.encode(body))
          .timeout(Duration(seconds: timeoutInSec));

      return right(res);
    } on SocketException catch (_) {
      return left(const NetworkFailure());
    } on HttpException catch (_) {
      return left(const RequestFailure("Cannot reach the server"));
    } on TimeoutException catch (_) {
      return left(const RequestFailure());
    } on Exception catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }
}
