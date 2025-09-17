class TaskModel {
  int? id;
  String title;
  String? description;
  String? priority;
  int categoryId;
  String? dueDate;
  bool completed;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  TaskModel({
    this.id,
    required this.title,
    this.description,
    this.priority,
    required this.categoryId,
    this.dueDate,
    this.completed = false,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    String? priority,
    int? categoryId,
    String? dueDate,
    bool? completed,
    String? imageUrl,
    String? createdAt,
    String? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      categoryId: categoryId ?? this.categoryId,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'category_id': categoryId,
      'due_date': dueDate,
      'completed': completed,
      'image_url': imageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String?,
      priority: json['priority'] as String?,
      categoryId: json['category_id'] as int,
      dueDate: json['due_date'] as String?,
      completed: json['completed'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
