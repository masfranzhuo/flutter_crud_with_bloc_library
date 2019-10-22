class User {
  int id;
  String name;
  String username;
  String email;

  User({
    this.id,
    this.name,
    this.username,
    this.email
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    username: json['username'] ?? '',
    email: json['email'] ?? ''
  );
  

  Map<String, dynamic> toJson() {
    var map = {
      'name': this.name ?? '',
      'username': this.username ?? '',
      'email': this.email ?? ''
    };

    if (map['id'] != null) map['id'] = this.id ?? '';

    return map;
  }
}