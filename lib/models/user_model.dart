class User {
  final String uid, email;
  User({
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'email': email});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map, String documentId) {
    return User(
      uid: documentId,
      email: map['email'] ?? '',
    );
  }
}
