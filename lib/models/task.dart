class Task {
  int? id;
  String? title;
  String? description;
  DateTime? date;
  bool isCompleted;
  bool isFavorite;

  Task({
    this.id,
    this.title,
    this.description,
    this.date,
    this.isCompleted = false,
    this.isFavorite = false,
  });

  /// Creates a new `Task` object by copying an existing one with optional overrides.
  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isCompleted,
    bool? isFavorite,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Factory constructor to create a `Task` object from a JSON map.
  /// Handles potential null values gracefully.
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'], // 'id' can be nullable if not present
      title: json['title'] ?? 'Untitled', // Default value if null
      description: json['description'] ?? 'No description', // Default value if null
      date: json['date'] != null ? DateTime.parse(json['date']) : null, // Handle null date
      isCompleted: json['isCompleted'] == 1, // SQLite stores booleans as integers (0 or 1)
      isFavorite: json['isFavorite'] == 1,
    );
  }

  /// Converts the `Task` object into a JSON map.
  /// Ensures all values are properly formatted for storage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title ?? 'Untitled', // Ensure title is never null
      'description': description ?? 'No description', // Ensure description is never null
      'date': date?.toIso8601String(), // Format date as ISO8601 if not null
      'isCompleted': isCompleted ? 1 : 0, // Convert to integer for SQLite
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
}
