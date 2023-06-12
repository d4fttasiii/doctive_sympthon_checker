class UserPersonalInformation {
  final String dateOfBirth;
  final String gender;
  final String countryCode;
  final String zipCode;
  final String city;
  final String street;
  final String streetNr;

  UserPersonalInformation({
    required this.dateOfBirth,
    required this.gender,
    required this.countryCode,
    required this.zipCode,
    required this.city,
    required this.street,
    required this.streetNr,
  });

  factory UserPersonalInformation.fromJson(Map<String, dynamic> json) {
    return UserPersonalInformation(
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      countryCode: json['countryCode'],
      zipCode: json['zipCode'],
      city: json['city'],
      street: json['street'],
      streetNr: json['streetNr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'countryCode': countryCode,
      'zipCode': zipCode,
      'city': city,
      'street': street,
      'streetNr': streetNr,
    };
  }
}
