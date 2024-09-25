class User {
  int id;
  String username;
  String email;
  String password;
  String number;
  String role;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.number,
    required this.role,
  });
  
  factory User.fromMap(map) {
    return User(
      id: map['id'] ?? 0, 
      username: map['username'] ?? 'Não informado', 
      email: map['email'] ?? 'Não informado', 
      password: map['password'] ?? 'Não informado', 
      number: map['number'] ?? 'Não informado', 
      role: map['role'] ?? 'user');
  }
}