class Task {
  int id;
  String title;
  String description;
  DateTime date;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}
