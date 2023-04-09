import '../todo.dart';

class UploadToDoResponse {
  final List<ToDo> receivedToDos;

  UploadToDoResponse({required this.receivedToDos});

  factory UploadToDoResponse.fromMap(Map<String, dynamic> map) {
    var result = (map['todos'] as List<dynamic>)
        .map<ToDo>((e) => ToDo.fromMap(e));
    return UploadToDoResponse(receivedToDos: List<ToDo>.from(result));
  }
}
