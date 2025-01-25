class User {
  String name;
  String phone;
  String email;
  String password;
  bool isRestaurant;
  String? restaurantName;
  String? restaurantAddress;

  User({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.isRestaurant = false,
    this.restaurantName,
    this.restaurantAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'isRestaurant': isRestaurant,
      'restaurantName': restaurantName,
      'restaurantAddress': restaurantAddress,
    };
  }
}