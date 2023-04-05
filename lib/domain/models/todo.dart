
import 'dart:ffi';

class ToDo {
  final String id;
  final String title;
  final bool complete;
  final Bool? synced;
  final Bool? deleted;
  final String created;

//<editor-fold desc="Data Methods">
  const ToDo({
    required this.id,
    required this.title,
    required this.complete,
    this.synced,
    this.deleted,
    required this.created,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ToDo &&
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
    return 'ToDo{ id: $id, title: $title, complete: $complete, synced: $synced, deleted: $deleted, created: $created,}';
  }

  ToDo copyWith({
    String? id,
    String? title,
    bool? complete,
    Bool? synced,
    Bool? deleted,
    String? created,
  }) {
    return ToDo(
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

  factory ToDo.fromMap(
    Map<String, dynamic> map, {
    String Function(String key)? keyMapper,
  }) {
    keyMapper ??= (key) => key;

    return ToDo(
      id: map[keyMapper('id')] as String,
      title: map[keyMapper('title')] as String,
      complete: map[keyMapper('complete')] as bool,
      synced: map[keyMapper('synced')] as Bool?,
      deleted: map[keyMapper('deleted')] as Bool?,
      created: map[keyMapper('created')] as String,
    );
  }

//</editor-fold>
}