class VerifyEmailDto {
  final String token;
  final String signature;

  VerifyEmailDto({required this.token, required this.signature});

  factory VerifyEmailDto.fromJson(Map<String, dynamic> json) {
    return VerifyEmailDto(
      token: json['token'],
      signature: json['signature'],
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'signature': signature,
      };
}
