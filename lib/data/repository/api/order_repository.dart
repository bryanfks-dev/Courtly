import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/create_order_dto.dart';
import 'package:courtly/data/dto/create_order_response_dto.dart';
import 'package:courtly/data/dto/order_detail_dto.dart';
import 'package:courtly/data/dto/order_detail_response_dto.dart';
import 'package:courtly/data/dto/order_dto.dart';
import 'package:courtly/data/dto/orders_response_dto.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:courtly/data/repository/local/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [OrderRepository] is the repository for the order feature.
class OrderRepository {
  /// [_apiRepository] is the instance of the [ApiRepository].
  final ApiRepository _apiRepository = ApiRepository();

  /// [_tokenRepository] is the instance of the [TokenRepository].
  final TokenRepository _tokenRepository = TokenRepository();

  /// [getOrders] is a method to get the orders.
  ///
  /// Returns a [Future] of [Either] of [Failure] or [List] of [OrderDTO].
  Future<Either<Failure, List<OrderDTO>>> getOrders({String? courtType}) async {
    // Set the token from the storage.
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    /// [queryParams] is the query parameters for the API request
    final Map<String, String> queryParams = {};

    // Check if the court type is not null
    if (courtType != null) {
      queryParams["type"] = courtType;
    }

    // Send a GET request to the server.
    final Either<Failure, http.Response> res = await _apiRepository.get(
        endpoint: "users/me/orders", queryParam: queryParams, timeoutInSec: 5);

    // Check if the result is a failure.
    if (res.isLeft()) {
      return left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Get the http response.
    final http.Response response = res.getOrElse(() => throw "No Response");

    // Parse the http response body
    final ResponseDTO<OrdersResponseDTO> responseDTO = ResponseDTO.fromJson(
        json: jsonDecode(response.body), fromJsonT: OrdersResponseDTO.fromJson);

    // Check if the response is successful.
    if (responseDTO.success) {
      return right(responseDTO.data!.orders);
    }

    // Check for status codes
    if (response.statusCode == HttpStatus.internalServerError) {
      return left(ServerFailure(responseDTO.message));
    }

    return left(UnknownFailure(responseDTO.message));
  }

  /// [createOrder] is the function to create the order.
  ///
  /// Parameters:
  ///   - [dto] is the data transfer object for the create order.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [String].
  Future<Either<Failure, String>> createOrder(
      {required CreateOrderDTO dto}) async {
    // Set the token from storage.
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Create the bookings.
    final Either<Failure, http.Response> res = await _apiRepository.post(
        endpoint: "users/me/orders", body: dto.toJson(), timeoutInSec: 5);

    // Check if the request fails.
    if (res.isLeft()) {
      return left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Get the response.
    final http.Response response = res.getOrElse(() => throw "No Response");

    // Parse the response.
    final ResponseDTO<CreateOrderResponseDTO> result = ResponseDTO.fromJson(
        json: jsonDecode(response.body),
        fromJsonT: CreateOrderResponseDTO.fromJson);

    // Check if the response is a success.
    if (result.success) {
      return right(result.data!.paymentToken);
    }

    // Check for different status codes.
    if (response.statusCode == HttpStatus.internalServerError) {
      return left(UnknownFailure(result.message));
    }

    if (response.statusCode == HttpStatus.badRequest) {
      return left(UnknownFailure(result.message));
    }

    return left(UnknownFailure(result.message));
  }

  /// [getOrderDetail] is the function to get the order detail.
  ///
  /// Parameters:
  ///   - [orderId] is the unique identifier of the order.
  ///
  /// Returns a [Future] of [Either] of [Failure] or [OrderDetailDTO].
  Future<Either<Failure, OrderDetailDTO>> getOrderDetail(
      {required int orderId}) async {
    // Set the token from storage.
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Send a GET request to the server.
    final Either<Failure, http.Response> res = await _apiRepository.get(
        endpoint: "users/me/orders/$orderId", timeoutInSec: 2);

    // Check if the request fails.
    if (res.isLeft()) {
      return left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Get the response.
    final http.Response response = res.getOrElse(() => throw "No Response");

    // Parse the response.
    final ResponseDTO<OrderDetailResponseDTO> result = ResponseDTO.fromJson(
        json: jsonDecode(response.body),
        fromJsonT: OrderDetailResponseDTO.fromJson);

    // Check if the response is a success.
    if (result.success) {
      return right(result.data!.orderDetail);
    }

    // Check for different status codes.
    if (response.statusCode == HttpStatus.internalServerError) {
      return left(UnknownFailure(result.message));
    }

    if (response.statusCode == HttpStatus.badRequest) {
      return left(UnknownFailure(result.message));
    }

    return left(UnknownFailure(result.message));
  }
}
