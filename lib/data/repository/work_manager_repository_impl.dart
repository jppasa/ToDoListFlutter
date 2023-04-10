import 'package:workmanager/workmanager.dart';

import '../../domain/models/responses/fetch_todo_list_response.dart';
import '../../domain/repositories/api_repository.dart';
import '../../domain/repositories/db_repository.dart';
import '../../domain/repositories/work_manager_repository.dart';
import '../../utils/constants.dart';
import '../data_state.dart';

const todoIdKey = "todoId";

class WorkManagerRepositoryImpl implements WorkManagerRepository {

  final Workmanager _workmanager = Workmanager();
  final ApiRepository _apiRepository;
  final DbRepository _dbRepository;

  WorkManagerRepositoryImpl(this._apiRepository, this._dbRepository);

  @override
  Future<DataState> executeDeletion(Map<String, dynamic> inputData) async {
    var stringId = inputData[todoIdKey] as String?;
    if (stringId != null) {
      var id = int.parse(stringId);
      var todo = await _dbRepository.getToDoById(id);

      if (todo != null) {
        var result = await _apiRepository.deleteTodo(todo);

        if (result is DataSuccess) {
          await _dbRepository.delete(todo);
        }

        return result;
      } else {
        return DataError("ToDo not found for id=$id");
      }
    }

    return DataError("ToDo not found for inputData=$inputData");
  }

  @override
  Future<DataState> executeDownload() async {
    DataState<FetchToDoListResponse> result = await _apiRepository.getToDoList();

    if (result is DataSuccess) {
      if (result is DataSuccess) {
        var data = (result as DataSuccess).data;
        _dbRepository.updateAll((data as FetchToDoListResponse).todoList);
      }
    }
    return result;
  }

  @override
  Future<DataState> executeUpload(Map<String, dynamic> inputData) async {
    var stringId = inputData[todoIdKey] as String?;
    if (stringId != null) {
      var id = int.parse(stringId);
      var todo = await _dbRepository.getToDoById(id);

      if (todo != null) {
        return await _apiRepository.uploadTodo(todo);
      } else {
        return DataError("ToDo not found for id=$id");
      }
    }

    return DataError("ToDo not found for inputData=$inputData");
  }

  // TODO work manager is canceling process before request is able to respond
  @override
  void scheduleToDoDeletion(String todoId) {
    var tag = "$deleteTodoFromRemote-$todoId";
    //_workmanager.cancelByTag(tag);
    _workmanager.registerOneOffTask(
      todosTaskIdentifier,
      deleteTodoFromRemote,
      tag: tag,
      constraints: Constraints(networkType: NetworkType.connected),
      inputData: {todoIdKey: todoId},
      existingWorkPolicy: ExistingWorkPolicy.replace,
      outOfQuotaPolicy: OutOfQuotaPolicy.run_as_non_expedited_work_request
    );
  }

  @override
  void scheduleToDosDownload() {
    _workmanager.cancelByTag(downloadTodos);
    _workmanager.registerOneOffTask(
      todosTaskIdentifier,
      downloadTodos,
      tag: downloadTodos,
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  @override
  void scheduleToDoUpload(String todoId) {
    var tag = "$uploadTodoUpdate-$todoId";
    _workmanager.cancelByTag(tag);
    _workmanager.registerOneOffTask(
      todosTaskIdentifier,
      uploadTodoUpdate,
      tag: tag,
      constraints: Constraints(networkType: NetworkType.connected),
      inputData: {todoIdKey: todoId},
    );
  }
}
