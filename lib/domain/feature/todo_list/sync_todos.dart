import 'result_state.dart';

import '../../../data/data_state.dart';
import '../../models/responses/fetch_todo_list_response.dart';
import '../../repositories/api_repository.dart';
import '../../repositories/db_repository.dart';

class FetchTodosUseCase {
  final ApiRepository _apiRepository;
  final DbRepository _dbRepository;

  FetchTodosUseCase(this._apiRepository, this._dbRepository);

  Future<ResultState> getToDoListFromRemote() async {
    DataState<FetchToDoListResponse> result =
        await _apiRepository.getToDoList();

    if (result is DataFailed) {
      return ResultState.error((result as DataFailed).error.message);
    } else {
      if (result is DataSuccess) {
        var data = (result as DataSuccess).data;
        _dbRepository.updateAll((data as FetchToDoListResponse).todoList);
      }

      return ResultState.success();
    }
  }
}
