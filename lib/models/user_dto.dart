class UserDto {
  final int id;
  final String walletAddress;
  final String firstname;
  final String lastname;
  final String email;
  final DateTime createdAt;
  final DateTime? modifiedAt;
  final bool lockEnabled;
  final int? loginAttempts;
  final DateTime? lockedUntil;
  final String? refreshToken;
  final bool isEmailVerified;
  final String? emailVerificationToken;
  final DateTime? emailVerifiedAt;

  UserDto({
    required this.id,
    required this.walletAddress,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.createdAt,
    this.modifiedAt,
    required this.lockEnabled,
    this.loginAttempts,
    this.lockedUntil,
    this.refreshToken,
    required this.isEmailVerified,
    this.emailVerificationToken,
    this.emailVerifiedAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      walletAddress: json['walletAddress'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: json['modifiedAt'] != null
          ? DateTime.parse(json['modifiedAt'])
          : null,
      lockEnabled: json['lockEnabled'] ?? false,
      loginAttempts: json['loginAttempts'] ?? 0,
      lockedUntil: json['lockedUntil'] != null
          ? DateTime.parse(json['lockedUntil'])
          : null,
      refreshToken: json['refreshToken'],
      isEmailVerified: json['isEmailVerified'] ?? false,
      emailVerificationToken: json['emailVerificationToken'],
      emailVerifiedAt: json['emailVerifiedAt'] != null
          ? DateTime.parse(json['emailVerifiedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'walletAddress': walletAddress,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'createdAt': createdAt.toIso8601String(),
        'modifiedAt': modifiedAt?.toIso8601String(),
        'lockEnabled': lockEnabled,
        'loginAttempts': loginAttempts,
        'lockedUntil': lockedUntil?.toIso8601String(),
        'refreshToken': refreshToken,
        'isEmailVerified': isEmailVerified,
        'emailVerificationToken': emailVerificationToken,
        'emailVerifiedAt': emailVerifiedAt?.toIso8601String(),
      };
}
