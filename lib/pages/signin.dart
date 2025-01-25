import 'package:flutter/material.dart';
import 'package:food_mobile_app_ui/model/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import '../navigator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin {
  final box = GetStorage();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _restaurantNameController = TextEditingController();
  final TextEditingController _restaurantAddressController = TextEditingController();
  bool isRestaurant = false;
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _heightAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void registerUser() {
    User user = User(
      name: _nameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      password: _passwordController.text,
      isRestaurant: isRestaurant,
      restaurantName: isRestaurant ? _restaurantNameController.text : null,
      restaurantAddress: isRestaurant ? _restaurantAddressController.text : null,
    );

    box.write('user', user.toJson());
    Get.offAll(() => const MainNavigator(), transition: Transition.cupertino);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text("ثبت نام", style: TextStyle(fontSize: 30)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/animations/6.json', height: 200, fit: BoxFit.cover),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text("ثبت‌نام به عنوان رستوران", textAlign: TextAlign.right),
                        value: isRestaurant,
                        onChanged: (bool value) {
                          setState(() {
                            isRestaurant = value;
                            if (isRestaurant) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(_nameController, "نام و نام خانوادگی", Icons.person),
                      _buildTextField(_phoneController, "شماره تلفن", Icons.phone),
                      _buildTextField(_emailController, "ایمیل", Icons.email),
                      _buildTextField(_passwordController, "رمز عبور", Icons.lock, obscureText: true),
                      SizeTransition(
                        sizeFactor: _heightAnimation,
                        axisAlignment: -1.0,
                        child: isRestaurant
                            ? Column(
                          children: [
                            _buildTextField(_restaurantNameController, "نام رستوران", Icons.store),
                            _buildTextField(_restaurantAddressController, "آدرس رستوران", Icons.location_on),
                          ],
                        )
                            : SizedBox.shrink(),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: registerUser,
                        child: const Text("ثبت‌نام", style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: hint,
          prefixIcon: Icon(icon, color: Colors.orangeAccent),
        ),
      ),
    );
  }
}
