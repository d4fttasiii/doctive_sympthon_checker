class SignableMessageDto {
  final String message;

  SignableMessageDto({required this.message});

  factory SignableMessageDto.fromJson(Map<String, dynamic> json) {
    return SignableMessageDto(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
