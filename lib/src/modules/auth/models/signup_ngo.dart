class SignUpNgo {
  late String username;
  late String email;
  late String password;
  late String name;
  late String description;
  late double latitude;
  late double longitude;
  late List<int> categories;

  SignUpNgo(String username_, String email_, String password_, String name_, String description_, double latitude_,
      double longitude_, List<int> categories_) {
    username = username_;
    email = email_;
    password = password_;
    name = name_;
    description = description_;
    latitude = latitude_;
    longitude = longitude_;
    categories = categories_;
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        'name': name,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'categories': categories,
      };
}
