class AppealType {
  final int id;
  final String name;
  final String? description;

  AppealType({
    required this.id,
    required this.name,
    this.description,
  });

  factory AppealType.fromJson(Map<String, dynamic> json) {
    return AppealType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}