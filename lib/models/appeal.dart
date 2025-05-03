import 'package:anti_corruption_app/models/appeal_type.dart';

class Appeal {
  final int id;
  final int userId;
  final int typeId;
  final String message;
  final String status;
  final String? adminComment;
  final bool isFake;
  final DateTime createdAt;
  final AppealType? type;
  final String? evidenceUrl;
  final String? selfieUrl;

  Appeal({
    required this.id,
    required this.userId,
    required this.typeId,
    required this.message,
    required this.status,
    this.adminComment,
    required this.isFake,
    required this.createdAt,
    this.type,
    this.evidenceUrl,
    this.selfieUrl,
  });

  factory Appeal.fromJson(Map<String, dynamic> json) {
    return Appeal(
      id: json['id'],
      userId: json['user_id'],
      typeId: json['type_id'],
      message: json['message'],
      status: json['status'],
      adminComment: json['admin_comment'],
      isFake: json['is_fake'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      type: json['type'] != null ? AppealType.fromJson(json['type']) : null,
      evidenceUrl: json['evidence_url'],
      selfieUrl: json['selfie_url'],
    );
  }
}