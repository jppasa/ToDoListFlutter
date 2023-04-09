class ToDo {
  final String id;
  final String title;
  final bool complete;
  final bool? synced;
  final bool? deleted;
  final String? created;

  static ToDo defaultInstance({required String title}) {
    var createdTimestampSeconds = DateTime
        .now()
        .millisecondsSinceEpoch ~/ 1000;

    return ToDo(
        id: '0',
        title: title,
        complete: false,
        synced: false,
        deleted: false,
        created: createdTimestampSeconds.toString());
  }

//<editor-fold desc="Data Methods">
  const ToDo({
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
    return 'ToDo{' +
        ' id: $id,' +
        ' title: $title,' +
        ' complete: $complete,' +
        ' synced: $synced,' +
        ' deleted: $deleted,' +
        ' created: $created,' +
        '}';
  }

  ToDo copyWith({
    String? id,
    String? title,
    bool? complete,
    bool? synced,
    bool? deleted,
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
      keyMapper('id'): this.id,
      keyMapper('title'): this.title,
      keyMapper('complete'): this.complete,
      keyMapper('synced'): this.synced,
      keyMapper('deleted'): this.deleted,
      keyMapper('created'): this.created,
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
      synced: map[keyMapper('synced')] as bool?,
      deleted: map[keyMapper('deleted')] as bool?,
      created: map[keyMapper('created')] as String?,
    );
  }

//</editor-fold>
}
