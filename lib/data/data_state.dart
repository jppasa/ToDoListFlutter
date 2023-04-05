import 'package:dio/dio.dart';

abstract class DataState<T> {
  const DataState();
  factory DataState.success(T data) = DataSuccess;
  factory DataState.failed(DioError error) = DataFailed;
}

class DataSuccess<T> extends DataState<T> {
  final T data;
  const DataSuccess(this.data) : super();
}

class DataFailed<T> extends DataState<T> {
  final DioError error;
  const DataFailed(this.error) : super();
}
