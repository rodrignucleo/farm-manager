class Costumer {
  final String? id;
  final String name;
  final String email;

  Costumer({
    this.id,
    required this.name,
    required this.email,
  });

  factory Costumer.fromMap(Map<String, dynamic> map) {
    return Costumer(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() => 'Costumer(id: $id, name: $name, email: $email)';
}
