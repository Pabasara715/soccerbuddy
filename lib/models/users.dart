class users {
  final String? id;
  final String username;
  final String password;

  const users({this.id, required this.username, required this.password});

  toJson() {
    return {
      "Username": username,
      "password": password,
    };
  }
}
