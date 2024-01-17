class users {
  final String? id;
  final String username;
  final String password;
  final List<Map<String, dynamic>> events;

  const users({
    this.id,
    required this.username,
    required this.password,
    required this.events,
  });

  toJson() {
    return {
      "id": username,
      "Username": username,
      "password": password,
      "events": events,
    };
  }
}
