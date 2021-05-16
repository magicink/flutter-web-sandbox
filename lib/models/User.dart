class User {
  final String avatar;
  final String email;
  final String firstName;
  final int id;
  final String lastName;

  User({this.avatar, this.email, this.firstName, this.id, this.lastName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User (
      avatar: json['avatar'],
      email: json['email'],
      firstName: json['firstName'],
      id: json['id'],
      lastName: json['lastName']
    );
  }
}