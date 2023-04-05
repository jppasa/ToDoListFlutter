import '../todo.dart';

class FetchToDoListResponse {
  final List<ToDo> todoList;

  FetchToDoListResponse({required this.todoList});

  factory FetchToDoListResponse.fromMap(Map<String, dynamic> map) {
    var result = (map['todos'] as List<dynamic>)
        .map<ToDo>((e) => ToDo.fromMap(e));
    print("Fetch result: $result");
    return FetchToDoListResponse(todoList: List<ToDo>.from(result));
  }
}
