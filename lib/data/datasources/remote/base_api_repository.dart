import 'dart:io' show HttpStatus;

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../data_state.dart';

abstract class BaseApiRepository {
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      print("getStateOf! $request");
      final httpResponse = await request();
      print("getStateOf response: $httpResponse");
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print("success!");
        return DataSuccess(httpResponse.data);
      } else {
        print("error! $httpResponse");
        throw DioError(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        );
      }
    } on DioError catch (error) {
      print("getStateOf error: $error");
      return DataFailed(error);
    }
  }
}
