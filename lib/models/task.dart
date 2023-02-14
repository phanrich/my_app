class Task {
  final String id;
  final String tilte;
  String? subTitle;
  bool? isDone;
  bool? isDeleted;

  Task(
      {required this.id,
      required this.tilte,
      this.subTitle,
      this.isDone,
      this.isDeleted}) {
    subTitle = subTitle ?? "";
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWith({
    String? id,
    String? tilte,
    String? subTitle,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      id: id ?? this.id,
      tilte: tilte ?? this.tilte,
      subTitle: subTitle ?? this.subTitle,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tilte': tilte,
      'subTitle': subTitle,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      tilte: map['tilte'],
      subTitle: map['subTitle'],
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }
}
