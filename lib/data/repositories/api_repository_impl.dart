import '../../../domain/models/responses/fetch_todo_list_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../data_state.dart';
import 'base_api_repository.dart';
import 'todo_service.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final ToDoService _service;

  ApiRepositoryImpl(this._service);

  @override
  Future<DataState<FetchToDoListResponse>> getToDoList() {
    return getStateOf<FetchToDoListResponse>(
        request: () => _service.getToDoList());
  }
}
