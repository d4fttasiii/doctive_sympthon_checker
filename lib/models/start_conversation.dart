class StartConversationDto {
  final String topic;

  StartConversationDto({
    required this.topic,
  });

  factory StartConversationDto.fromJson(Map<String, dynamic> json) {
    return StartConversationDto(
      topic: json['topic'],
    );
  }

  Map<String, dynamic> toJson() => {
        'topic': topic,
      };
}
