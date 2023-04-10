import '../../../data/data_state.dart';
import '../../models/todo.dart';
import '../../repositories/api_repository.dart';
import '../../repositories/db_repository.dart';
import '../../repositories/work_manager_repository.dart';
import 'result_state.dart';

class UpdateTodoUseCase {
  final ApiRepository _apiRepository;
  final DbRepository _dbRepository;
  final WorkManagerRepository _workManagerRepository;

  UpdateTodoUseCase(this._apiRepository, this._dbRepository, this._workManagerRepository);

  Future<ResultState> update(ToDo todo) async {
    await _dbRepository.updateToDo(todo.copyWith(synced: false));

    // if (todo.deleted == true) {
    //   _workManagerRepository.scheduleToDoDeletion(todo.id);
    // } else {
    //   _workManagerRepository.scheduleToDoUpload(todo.id);
    // }

    if (todo.deleted == true) {
      var result = await _apiRepository.deleteTodo(todo);

      if (result is DataFailed) {
        return ResultState.error((result as DataFailed).error.message);
      } else {
        _dbRepository.delete(todo);
        return ResultState.success();
      }
    } else {
      var result = await _apiRepository.uploadTodo(todo);

      if (result is DataFailed) {
        return ResultState.error((result as DataFailed).error.message);
      } else {
        _dbRepository.setToDoAsSyncedById(int.parse(todo.id));
        return ResultState.success();
      }
    }
  }
}
