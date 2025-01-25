import 'package:flutter/material.dart';
import 'package:food_mobile_app_ui/navigator.dart';
import 'package:food_mobile_app_ui/pages/signin.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final box = GetStorage();

  void _login() {
    Map<String, dynamic>? storedUser = box.read('user');
    if (storedUser != null &&
        storedUser['email'] == _usernameController.text &&
        storedUser['password'] == _passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ورود موفقیت‌آمیز بود!", style: TextStyle(color: Colors.white)), backgroundColor: Colors.green,)
      );
      Get.offAll(()=> const MainNavigator(),
          transition: Transition.cupertino);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("نام کاربری یا رمز عبور اشتباه است!", style: TextStyle(color: Colors.white)), backgroundColor: Colors.red,)
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ورود",style: TextStyle(fontSize: 30),),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Lottie.asset( "assets/animations/5.json",height: 300),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      spreadRadius: 3,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "نام کاربری",
                        prefixIcon: const Icon(Icons.person, color: Colors.orange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "رمز عبور",
                        prefixIcon: const Icon(Icons.lock, color: Colors.orange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child:  const Text("ورود", style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.to(()=> const SignUpPage(),
                      transition: Transition.cupertino);
                },
                child: const Text("ثبت‌نام", style: TextStyle( fontSize: 18,fontWeight:FontWeight.w500,color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
