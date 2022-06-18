const String tableTasks = 'task';

class NoteTasks {
  static final List<String> values = [
    id,
    isImportant,
    number,
    title,
    description,
    time
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class TaskModel {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  TaskModel({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  TaskModel copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      TaskModel(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static TaskModel fromJson(Map<String, Object?> json) => TaskModel(
        id: json[NoteTasks.id] as int?,
        isImportant: json[NoteTasks.isImportant] == 1,
        number: json[NoteTasks.number] as int,
        title: json[NoteTasks.title] as String,
        description: json[NoteTasks.description] as String,
        createdTime: DateTime.parse(json[NoteTasks.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteTasks.id: id,
        NoteTasks.isImportant: isImportant ? 1 : 0,
        NoteTasks.number: number,
        NoteTasks.title: title,
        NoteTasks.description: description,
        NoteTasks.time: createdTime.toIso8601String(),
      };
}
