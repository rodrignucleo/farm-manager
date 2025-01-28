class Costumer {
  final String name;
  final String email;

  Costumer({
    required this.name,
    required this.email,
  });

  factory Costumer.fromMap(Map<String, dynamic> map) {
    return Costumer(
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() => 'Costumer(name: $name, email: $email)';
}
