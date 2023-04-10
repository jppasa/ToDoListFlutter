import '../todo.dart';

class DeleteToDoResponse {
  final List<ToDo> receivedToDos;

  DeleteToDoResponse({required this.receivedToDos});

  factory DeleteToDoResponse.fromMap(Map<String, dynamic> map) {
    print("Delete response map: $map");
    var result = (map['todos'] as List<dynamic>)
        .map<ToDo>((e) => ToDo.fromMap(e));
    print("Delete response result: $result");
    return DeleteToDoResponse(receivedToDos: List<ToDo>.from(result));
  }
}
