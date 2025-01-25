import 'package:flutter/material.dart';
import 'package:food_mobile_app_ui/pages/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

//
import '../controllers/drawer_controller.dart';
import '../controllers/navigator_controllers.dart';
import '../model/drawer_model.dart';

const w = 390.0;
const h = 844.0;

const Color unSelectedColor = Color.fromARGB(255, 234, 234, 234);

Drawer mainDrawer(int index) {
  var controller = Get.find<MainDrawerController>();
  final navController = Get.find<NavigatorController>();
  controller.changeIndex(index);
  final box = GetStorage();
  Map<String, dynamic>? storedUser = box.read('user');

  return Drawer(
    child: Column(
      children: [
        Container(
          width: w,
          height: h / 4,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/drawer.jpg'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/me.jpg"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(storedUser?['name'],
                    style: GoogleFonts.oxygen(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                const SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
        ),
        GetBuilder<MainDrawerController>(
            id: "current Drawer Itme Index",
            builder: (context) {
              return Container(
                  margin: const EdgeInsets.all(20),
                  width: w,
                  height: h / 1.75,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: drawerItem.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.changeIndex(index);
                          print(index);
                          switch (index) {
                            case 0:
                              navController.changeNavBarIndex(2);
                              break;

                            case 1:
                              navController.changeNavBarIndex(1);
                              break;

                            case 3:
                              navController.changeNavBarIndex(0);
                              break;

                            case 4:
                              Navigator.pop(context);
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "خروج از برنامه",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.orange),
                                    ),
                                    content: const SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            "آیا مطمئن هستید که می‌خواهید از برنامه خارج شوید؟",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("خیر",
                                            style: TextStyle(
                                                color: Colors.orange)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("بله",
                                            style:
                                                TextStyle(color: Colors.red)),
                                        onPressed: () {
                                          final box = GetStorage();
                                          box.remove('user');
                                          Get.offAll(() => const LoginPage(),
                                              transition: Transition.cupertino);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );

                              break;

                            default:
                          }
                        },
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            tileColor:
                                controller.currentDrawerItmeIndex == index
                                    ? const Color.fromARGB(255, 227, 191, 180)
                                        .withOpacity(0.4)
                                    : Colors.transparent,
                            leading: Icon(
                              drawerItem[index].icon,
                              color: controller.currentDrawerItmeIndex == index
                                  ? Colors.deepOrange
                                  : Colors.grey,
                            ),
                            title: Text(
                              drawerItem[index].title,
                              style: TextStyle(
                                color:
                                    controller.currentDrawerItmeIndex == index
                                        ? Colors.deepOrange
                                        : Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      if (index == 6) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ));
            }),
      ],
    ),
  );
}
