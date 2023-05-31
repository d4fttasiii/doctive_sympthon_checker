class SendMessageDto {
  final String text;

  SendMessageDto({
    required this.text,
  });

  factory SendMessageDto.fromJson(Map<String, dynamic> json) {
    return SendMessageDto(
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text,
      };
}
