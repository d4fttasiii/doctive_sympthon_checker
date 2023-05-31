class UserUpdateDto {
  final String firstname;
  final String lastname;
  final String email;

  UserUpdateDto({
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  factory UserUpdateDto.fromJson(Map<String, dynamic> json) {
    return UserUpdateDto(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
      };
}
