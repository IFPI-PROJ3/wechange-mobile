class SignUpVolunteer {
  late String username;
  late String email;
  late String password;
  late String name;
  late String lastname;
  late String description;
  late double latitude;
  late double longitude;
  late List<int> categories;

  SignUpVolunteer(String username_, String email_, String password_, String name_, String lastname_,
      String description_, double latitude_, double longitude_) {
    username = username_;
    email = email_;
    password = password_;
    name = name_;
    lastname = lastname_;
    description = description_;
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        'name': name,
        'lastname': lastname,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'categories': categories,
      };
}
