class User {
  final String id;
  final String email;
  final String name;
  final String? emailVerifiedAt;
  final String? type;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.type,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      email: json['email'],
      name: json['name'],
      type: json['type'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
