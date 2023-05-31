class UserConversationMessageDto {
  final String type;
  final String channelId;
  final String id;
  // You might need to create another class for the `from` field if it's an object.
  final Object from;
  final String text;

  UserConversationMessageDto({
    required this.type,
    required this.channelId,
    required this.id,
    required this.from,
    required this.text,
  });

  factory UserConversationMessageDto.fromJson(Map<String, dynamic> json) {
    return UserConversationMessageDto(
      type: json['type'],
      channelId: json['channelId'],
      id: json['id'],
      from: json['from'], // Cast this to the appropriate type.
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'channelId': channelId,
        'id': id,
        'from': from, // This needs to be serialized properly.
        'text': text,
      };
}
