class UserConversationDto {
  final int id;
  final int userId;
  final String conversationId;
  final DateTime createdAt;
  final DateTime? endedAt;

  UserConversationDto({
    required this.id,
    required this.userId,
    required this.conversationId,
    required this.createdAt,
    required this.endedAt,
  });

  factory UserConversationDto.fromJson(Map<String, dynamic> json) {
    return UserConversationDto(
      id: json['id'],
      userId: json['userId'],
      conversationId: json['conversationId'],
      createdAt: DateTime.parse(json['createdAt']),
      endedAt: json['endedAt'] != null ? DateTime.parse(json['endedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'conversationId': conversationId,
        'createdAt': createdAt.toIso8601String(),
        'endedAt': endedAt?.toIso8601String(),
      };
}
