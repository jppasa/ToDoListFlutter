import '../../data/data_state.dart';
import '../models/responses/fetch_todo_list_response.dart';
import '../models/responses/upload_todo_response.dart';
import '../models/todo.dart';

abstract class ApiRepository {
  Future<DataState<FetchToDoListResponse>> getToDoList();
  Future<DataState<UploadToDoResponse>> uploadTodo(ToDo toDo);
}