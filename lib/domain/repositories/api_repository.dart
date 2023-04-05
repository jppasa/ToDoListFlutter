import '../../data/data_state.dart';
import '../models/responses/fetch_todo_list_response.dart';

abstract class ApiRepository {
  Future<DataState<FetchToDoListResponse>> getToDoList();
}