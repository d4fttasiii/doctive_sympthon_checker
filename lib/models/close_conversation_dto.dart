class CloseConversationDto {
  final bool wasItHelpful;

  CloseConversationDto({required this.wasItHelpful});

  factory CloseConversationDto.fromJson(Map<String, dynamic> json) {
    return CloseConversationDto(
      wasItHelpful: json['wasItHelpful'],
    );
  }

  Map<String, dynamic> toJson() => {
        'wasItHelpful': wasItHelpful,
      };
}
