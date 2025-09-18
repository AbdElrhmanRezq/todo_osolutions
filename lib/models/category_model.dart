class CategoryModel {
  int id;
  String name;
  String color;
  String iconUrl;
  String imageFilter;
  int imageSeedOffset;
  String createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.iconUrl,
    required this.imageFilter,
    required this.imageSeedOffset,
    required this.createdAt,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    String? color,
    String? iconUrl,
    String? imageFilter,
    int? imageSeedOffset,
    String? createdAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      iconUrl: iconUrl ?? this.iconUrl,
      imageFilter: imageFilter ?? this.imageFilter,
      imageSeedOffset: imageSeedOffset ?? this.imageSeedOffset,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'icon_url': iconUrl,
      'image_filter': imageFilter,
      'image_seed_offset': imageSeedOffset,
      'created_at': createdAt,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      color: json['color'] as String,
      iconUrl: json['icon_url'] as String,
      imageFilter: json['image_filter'] as String,
      imageSeedOffset: json['image_seed_offset'] as int,
      createdAt: json['created_at'] as String,
    );
  }
}
