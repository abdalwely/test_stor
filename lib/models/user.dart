class User {
  final String id;
  final String? email;
  final String? phoneNumber;
  final String? country;
  final bool isLoggedIn;

  User({
    required this.id,
    this.email,
    this.phoneNumber,
    this.country,
    required this.isLoggedIn,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      country: json['country'],
      isLoggedIn: json['isLoggedIn'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'phoneNumber': phoneNumber,
    'country': country,
    'isLoggedIn': isLoggedIn,
  };

  User copyWith({
    String? id,
    String? email,
    String? phoneNumber,
    String? country,
    bool? isLoggedIn,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
