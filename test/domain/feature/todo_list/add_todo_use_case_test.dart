import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/data/data_state.dart';
import 'package:todo_list/domain/feature/todo_list/add_todo_use_case.dart';
import 'package:todo_list/domain/feature/todo_list/result_state.dart';
import 'package:todo_list/domain/models/responses/upload_todo_response.dart';
import 'package:todo_list/domain/repositories/api_repository.dart';
import 'package:todo_list/domain/repositories/db_repository.dart';

@GenerateNiceMocks([MockSpec<ApiRepository>(), MockSpec<DbRepository>()])
import 'add_todo_use_case_test.mocks.dart';

void main() {
  var apiRepositoryMock = MockApiRepository();
  var dbRepositoryMock = MockDbRepository();

  test("Add use case success", () async {
    when(dbRepositoryMock.storeToDo(any)).thenAnswer((_) async => 1);
    when(apiRepositoryMock.uploadTodo(any))
        .thenAnswer((_) async => DataState.success(UploadToDoResponse.fromMap({"todos": []})));

    var addToListUseCase = AddToDoListUseCase(apiRepositoryMock, dbRepositoryMock);

    var result = await addToListUseCase.addTodoFromTextAndSync("anything");
    verify(dbRepositoryMock.storeToDo(any)).called(1);
    verify(apiRepositoryMock.uploadTodo(any)).called(1);
    verify(dbRepositoryMock.setToDoAsSyncedById(any)).called(1);

    assert(result is SyncStateSuccess);
  });

  test("Add use case failure", () async {
    when(dbRepositoryMock.storeToDo(any)).thenAnswer((_) async => 1);
    when(apiRepositoryMock.uploadTodo(any)).thenAnswer(
      (_) async => DataState.failed(
        DioError.connectionError(
          requestOptions: RequestOptions(),
          reason: "",
        ),
      ),
    );

    var addToListUseCase = AddToDoListUseCase(apiRepositoryMock, dbRepositoryMock);

    var result = await addToListUseCase.addTodoFromTextAndSync("anything");
    verify(dbRepositoryMock.storeToDo(any)).called(1);
    verify(apiRepositoryMock.uploadTodo(any)).called(1);
    verifyNever(dbRepositoryMock.setToDoAsSyncedById(any));

    assert(result is SyncStateError);
  });
}
