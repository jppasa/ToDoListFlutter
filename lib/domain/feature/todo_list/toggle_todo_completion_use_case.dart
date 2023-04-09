import '../../../data/data_state.dart';
import '../../models/responses/upload_todo_response.dart';
import '../../models/todo.dart';
import '../../repositories/api_repository.dart';
import '../../repositories/db_repository.dart';
import 'result_state.dart';

class ToggleTodoCompletionUseCase {
  final ApiRepository _apiRepository;
  final DbRepository _dbRepository;

  ToggleTodoCompletionUseCase(this._apiRepository, this._dbRepository);

  Future<ResultState> toggleCompletion(ToDo todo, bool completed) async {
    var newTodo = todo.copyWith(complete: completed, synced: false);
    await _dbRepository.updateToDo(newTodo);

    // TODO sync using work manager
    var result = await _apiRepository.uploadTodo(newTodo);

    if (result is DataFailed) {
      return ResultState.error((result as DataFailed).error.message);
    } else {
      _dbRepository.setToDoAsSyncedById(int.parse(todo.id)); // TODO avoid parse, change type of model
      return ResultState.success();
    }
  }
}
