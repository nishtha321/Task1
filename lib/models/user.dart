class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
    );
  }
}
