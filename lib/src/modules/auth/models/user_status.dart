class UserStatus {
  late String id;
  late String username;
  late String email;
  late bool active;
  late String role;

  UserStatus(
    String id_,
    String username_,
    String email_,
    bool active_,
    String role_,
  ) {
    id = id_;
    username = username_;
    email = email_;
    active = active_;
    role = role_;
  }

  UserStatus.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        active = json['active'],
        role = json['role'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'active': active,
        'role': role,
      };
}
