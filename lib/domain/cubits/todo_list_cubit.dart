import '../../data/data_state.dart';
import '../../presentation/todo_list/todo_list_state.dart';
import '../models/responses/fetch_todo_list_response.dart';
import '../models/todo.dart';
import '../repositories/api_repository.dart';
import 'base_cubit.dart';

class ToDoListCubit extends BaseCubit<ToDoListState, List<ToDo>> {
  final ApiRepository _apiRepository;

  ToDoListCubit(this._apiRepository) : super(ToDoListState.loading(), []);

  Future<void> getToDoList() async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.getToDoList();

      if (response is DataSuccess) {
        final successStatus = response as DataSuccess;
        final toDoList = (successStatus.data as FetchToDoListResponse).todoList;
        emit(ToDoListState.success(toDoList));
      } else if (response is DataFailed) {
        var error = (response as DataFailed).error;
        emit(ToDoListState.error(error));
      }
    });
  }
}
