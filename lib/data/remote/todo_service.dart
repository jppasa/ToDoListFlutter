import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/responses/fetch_todo_list_response.dart';
import '../../../utils/constants.dart';
import '../../domain/models/responses/upload_todo_response.dart';
import '../../domain/models/todo.dart';

part 'todo_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.MapSerializable)
abstract class ToDoService {
  factory ToDoService(Dio dio, {String baseUrl}) = _ToDoService;
  
  @GET('/api/v1/todo')
  Future<HttpResponse<FetchToDoListResponse>> getToDoList();

  @POST('/api/v1/todo')
  Future<HttpResponse<UploadToDoResponse>> uploadToDo(@Body() ToDo toDo);
}