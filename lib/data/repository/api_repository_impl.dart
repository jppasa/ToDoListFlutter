import '../../../domain/models/responses/fetch_todo_list_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../domain/models/responses/delete_todo_response.dart';
import '../../domain/models/responses/upload_todo_response.dart';
import '../../domain/models/todo.dart';
import '../data_state.dart';
import '../remote/todo_service.dart';
import 'base_api_repository.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final ToDoService _service;

  ApiRepositoryImpl(this._service);

  @override
  Future<DataState<FetchToDoListResponse>> getToDoList() {
    return getStateOf<FetchToDoListResponse>(request: () => _service.getToDoList());
  }

  @override
  Future<DataState<UploadToDoResponse>> uploadTodo(ToDo toDo) {
    return getStateOf<UploadToDoResponse>(request: () => _service.uploadToDo(toDo));
  }

  @override
  Future<DataState<DeleteToDoResponse>> deleteTodo(ToDo todo) {
    return getStateOf<DeleteToDoResponse>(request: () => _service.deleteToDoById(todo.id));
  }
}
