import 'package:floor/floor.dart';

import '../../../../utils/constants.dart';

@Entity(tableName: todosTable)
class ToDoEntity {
  @PrimaryKey(autoGenerate: true)
  final String id;

  final String title;
  final bool complete;
  final bool synced;
  final bool deleted;
  final String created;

//<editor-fold desc="Data Methods">
  const ToDoEntity({
    required this.id,
    required this.title,
    required this.complete,
    required this.synced,
    required this.deleted,
    required this.created,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ToDoEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          complete == other.complete &&
          synced == other.synced &&
          deleted == other.deleted &&
          created == other.created);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      complete.hashCode ^
      synced.hashCode ^
      deleted.hashCode ^
      created.hashCode;

  @override
  String toString() {
    return 'ToDoEntity{ id: $id, title: $title, complete: $complete, synced: $synced, deleted: $deleted, created: $created,}';
  }

  ToDoEntity copyWith({
    String? id,
    String? title,
    bool? complete,
    bool? synced,
    bool? deleted,
    String? created,
  }) {
    return ToDoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      complete: complete ?? this.complete,
      synced: synced ?? this.synced,
      deleted: deleted ?? this.deleted,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap({
    String Function(String key)? keyMapper,
  }) {
    keyMapper ??= (key) => key;

    return {
      keyMapper('id'): id,
      keyMapper('title'): title,
      keyMapper('complete'): complete,
      keyMapper('synced'): synced,
      keyMapper('deleted'): deleted,
      keyMapper('created'): created,
    };
  }

  factory ToDoEntity.fromMap(
    Map<String, dynamic> map, {
    String Function(String key)? keyMapper,
  }) {
    keyMapper ??= (key) => key;

    return ToDoEntity(
      id: map[keyMapper('id')] as String,
      title: map[keyMapper('title')] as String,
      complete: map[keyMapper('complete')] as bool,
      synced: map[keyMapper('synced')] as bool,
      deleted: map[keyMapper('deleted')] as bool,
      created: map[keyMapper('created')] as String,
    );
  }

//</editor-fold>
}
