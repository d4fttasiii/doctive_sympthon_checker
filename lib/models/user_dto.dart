class UserDto {
  final int id;
  final String walletAddress;
  final String firstname;
  final String lastname;
  final String email;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final bool lockEnabled;
  final int loginAttempts;
  final DateTime lockedUntil;
  final String refreshToken;
  final bool isEmailVerified;
  final String emailVerificationToken;
  final DateTime emailVerifiedAt;

  UserDto({
    required this.id,
    required this.walletAddress,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.createdAt,
    required this.modifiedAt,
    required this.lockEnabled,
    required this.loginAttempts,
    required this.lockedUntil,
    required this.refreshToken,
    required this.isEmailVerified,
    required this.emailVerificationToken,
    required this.emailVerifiedAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      walletAddress: json['walletAddress'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: DateTime.parse(json['modifiedAt']),
      lockEnabled: json['lockEnabled'],
      loginAttempts: json['loginAttempts'],
      lockedUntil: DateTime.parse(json['lockedUntil']),
      refreshToken: json['refreshToken'],
      isEmailVerified: json['isEmailVerified'],
      emailVerificationToken: json['emailVerificationToken'],
      emailVerifiedAt: DateTime.parse(json['emailVerifiedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'walletAddress': walletAddress,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'createdAt': createdAt.toIso8601String(),
        'modifiedAt': modifiedAt.toIso8601String(),
        'lockEnabled': lockEnabled,
        'loginAttempts': loginAttempts,
        'lockedUntil': lockedUntil.toIso8601String(),
        'refreshToken': refreshToken,
        'isEmailVerified': isEmailVerified,
        'emailVerificationToken': emailVerificationToken,
        'emailVerifiedAt': emailVerifiedAt.toIso8601String(),
      };
}
