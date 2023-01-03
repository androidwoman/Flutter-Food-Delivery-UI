import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class DrawerItemModel {
  IconData icon;
  String title;
  //
  DrawerItemModel({
    required this.icon,
    required this.title,
  });
}

List<DrawerItemModel> drawerItem = [
  DrawerItemModel(icon: LineIcons.user, title: "صفحه کاربری"),
  DrawerItemModel(icon: LineIcons.wallet, title: "کیف پول"),
  DrawerItemModel(icon: LineIcons.barChart, title: "فعالیت ها"),
  DrawerItemModel(icon: LineIcons.hamburger, title: "غذاها"),
  DrawerItemModel(icon: LineIcons.alternateSignIn, title: "خروج از حساب کاربری"),
  
  
];