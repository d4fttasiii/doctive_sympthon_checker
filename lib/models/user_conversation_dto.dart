class UserConversationDto {
  final int id;
  final int userId;
  final String conversationId;
  final DateTime createdAt;
  final DateTime? endedAt;
  final String token;
  final int expiresIn;
  final String streamUrl;
  final bool hasEnded;
  final String topic;
  final bool? wasItHelpful;

  UserConversationDto({
    required this.id,
    required this.userId,
    required this.conversationId,
    required this.createdAt,
    this.endedAt,
    required this.token,
    required this.expiresIn,
    required this.streamUrl,
    required this.hasEnded,
    required this.topic,
    this.wasItHelpful,
  });

  factory UserConversationDto.fromJson(Map<String, dynamic> json) {
    return UserConversationDto(
      id: json['id'],
      userId: json['userId'],
      conversationId: json['conversationId'],
      createdAt: DateTime.parse(json['createdAt']),
      endedAt: json['endedAt'] != null
          ? DateTime.parse(json['endedAt'])
          : null,
      token: json['token'],
      expiresIn: json['expiresIn'],
      streamUrl: json['streamUrl'],
      hasEnded: json['hasEnded'],
      topic: json['topic'],
      wasItHelpful: json['wasItHelpful'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'conversationId': conversationId,
        'createdAt': createdAt.toIso8601String(),
        'endedAt': endedAt?.toIso8601String(),
        'token': token,
        'expiresIn': expiresIn,
        'streamUrl': streamUrl,
        'hasEnded': hasEnded,
        'topic': topic,
        'wasItHelpful': wasItHelpful,
      };
}
