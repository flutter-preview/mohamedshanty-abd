class UserModel {
  String department, email, id, role;

  UserModel({
    required this.department,
    required this.email,
    required this.id,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'department': department,
      'email': email,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      department: map['department'].toString(),
      email: map['email'].toString(),
      id: map['id'].toString(),
      role: map['role'].toString(),
    );
  }
}
