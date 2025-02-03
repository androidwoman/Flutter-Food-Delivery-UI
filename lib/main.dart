import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

///
import '../pages/splash.dart';
import '../bindings/all_bindings.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FeatureDiscovery(child:GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Mobile App UI Design',
      initialBinding: MyBindings(),
      color: Colors.orange,

      theme: ThemeData(
          primaryColor:Colors.orange ,
          scaffoldBackgroundColor: Colors.orange.shade50,
          appBarTheme:AppBarTheme(backgroundColor: Colors.orange.shade50) ,
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.orange;
              }
              return Colors.grey;
            }),
            trackColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.orange.shade100;
              }
              return Colors.grey.shade300;
            }),
          ),

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.orange, width: 2),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.orange.shade300),
            ),
          )),
      textDirection: TextDirection.rtl,
      home: const SplashPage(),
    ));
  }
}
