class Appeal {
  final int id;
  final int userId;
  final int typeId;
  final String message;
  final String status;
  final String? adminComment;
  final bool isFake;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? evidenceUrl;
  final String? selfieUrl;
  final AppealType? type;

  Appeal({
    required this.id,
    required this.userId,
    required this.typeId,
    required this.message,
    required this.status,
    this.adminComment,
    required this.isFake,
    required this.createdAt,
    required this.updatedAt,
    this.evidenceUrl,
    this.selfieUrl,
    this.type,
  });

  factory Appeal.fromJson(Map<String, dynamic> json) {
    return Appeal(
      id: json['id'],
      userId: json['user_id'],
      typeId: json['type_id'],
      message: json['message'],
      status: json['status'],
      adminComment: json['admin_comment'],
      isFake: json['is_fake'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      evidenceUrl: json['evidence_url'],
      selfieUrl: json['selfie_url'],
      type: json['type'] != null ? AppealType.fromJson(json['type']) : null,
    );
  }
}