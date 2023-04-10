import '../../../data/data_state.dart';
import '../../models/todo.dart';
import '../../repositories/api_repository.dart';
import '../../repositories/db_repository.dart';
import 'result_state.dart';

class AddToDoListUseCase {
  final ApiRepository _apiRepository;
  final DbRepository _dbRepository;

  AddToDoListUseCase(this._apiRepository, this._dbRepository);

  Future<ResultState> addTodoFromTextAndSync(String todoText) async {
    var newTodo = ToDo.defaultInstance(title: todoText.trim());
    var storedTodoId = await _dbRepository.storeToDo(newTodo);
    var storedTodo = newTodo.copyWith(id: storedTodoId.toString());

    // TODO sync using work manager
    var result = await _apiRepository.uploadTodo(storedTodo);

    if (result is DataFailed) {
      return ResultState.error((result as DataFailed).error.message);
    } else {
      _dbRepository.setToDoAsSyncedById(storedTodoId);
      return ResultState.success();
    }
  }
}
