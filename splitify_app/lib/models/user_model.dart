class User {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "phone": phone,
    };
  }
}
