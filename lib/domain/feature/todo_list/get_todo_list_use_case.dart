
import '../../models/todo.dart';
import '../../repositories/db_repository.dart';

class GetToDoListUseCase {
  final DbRepository _dbRepository;

  GetToDoListUseCase(this._dbRepository);

  Stream<List<ToDo>> getToDoListLocally() {
    return _dbRepository.getToDosAsStream();
  }
}