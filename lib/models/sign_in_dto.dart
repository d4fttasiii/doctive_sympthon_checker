class SignInDto {
  final String walletAddress;
  final String signature;

  SignInDto({required this.walletAddress, required this.signature});

  factory SignInDto.fromJson(Map<String, dynamic> json) {
    return SignInDto(
      walletAddress: json['walletAddress'],
      signature: json['signature'],
    );
  }

  Map<String, dynamic> toJson() => {
        'walletAddress': walletAddress,
        'signature': signature,
      };
}
