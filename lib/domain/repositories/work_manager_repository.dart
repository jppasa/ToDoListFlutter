import '../../data/data_state.dart';

abstract class WorkManagerRepository {
  void scheduleToDosDownload();
  void scheduleToDoUpload(String todoId);
  void scheduleToDoDeletion(String todoId);
  Future<DataState> executeDownload();
  Future<DataState> executeUpload(Map<String, dynamic> inputData);
  Future<DataState> executeDeletion(Map<String, dynamic> inputData);
}