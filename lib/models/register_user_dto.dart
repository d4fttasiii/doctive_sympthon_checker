class RegisterUserDto {
  final String? walletAddress;
  final String firstname;
  final String lastname;
  final String email;
  final String? message;
  final String? signature;

  RegisterUserDto({
    this.walletAddress,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.message,
    this.signature,
  });

  factory RegisterUserDto.fromJson(Map<String, dynamic> json) {
    return RegisterUserDto(
      walletAddress: json['walletAddress'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      message: json['message'],
      signature: json['signature'],
    );
  }

  Map<String, dynamic> toJson() => {
        'walletAddress': walletAddress,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'message': message,
        'signature': signature,
      };
}
