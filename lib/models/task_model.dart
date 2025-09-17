class TaskModel {
  String title;
  String? description;
  int categoryId;
  String? dueDate;
  bool completed;
  String? imageUrl;

  TaskModel({
    required this.title,
    this.description,
    required this.categoryId,
    this.dueDate,
    this.completed = false,
    this.imageUrl,
  });

  TaskModel copyWith({
    String? title,
    String? description,
    int? categoryId,
    String? dueDate,
    bool? completed,
    String? imageUrl,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category_id': categoryId,
      'due_date': dueDate,
      'completed': completed,
      'image_url': imageUrl,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'] as String,
      description: json['description'] as String?,
      categoryId: json['category_id'] as int,
      dueDate: json['due_date'] ?? " ",
      completed: json['completed'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
    );
  }
}
