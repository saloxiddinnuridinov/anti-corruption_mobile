class User {
  final int? id;
  final String? oneId;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final bool? isBlocked;
  final int? warningCount;

  User({
    this.id,
    this.oneId,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.isBlocked,
    this.warningCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      oneId: json['one_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      isBlocked: json['is_blocked'],
      warningCount: json['warning_count'],
    );
  }
}