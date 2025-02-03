import 'package:animate_do/animate_do.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:food_mobile_app_ui/controllers/tabbar_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//
import '../controllers/navigator_controllers.dart';
import '../controllers/food_controller.dart';
import '../controllers/wallet_controller.dart';
import '../controllers/switch_controller.dart';
import '../pages/details.dart';

import '../utils/constanst.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(3),
      appBar: const MyAppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            const TopTextWidget(),
            TabBar(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('پر فروش ترین های امروز',
                      style: GoogleFonts.oxygen(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      )),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: TextButton.icon(
                      onPressed: () {
                        // Add your navigation or action here
                      },
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.orange),
                      label: Text(
                        'مشاهده همه',
                        style: GoogleFonts.oxygen(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const MiddleSaladsPageView(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('پیشنهاد کابران',
                  style: GoogleFonts.oxygen(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  )),
            ),
            const BottomSaladGridView(),
          ],
        ),
      ),
    );
  }
}

/// Bottom Salad GridView Widget Components
class BottomSaladGridView extends StatelessWidget {
  const BottomSaladGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Get.find<SwitchController>();
    var _tabController = Get.find<TabBarController>();
    var _foodController = Get.find<FoodController>();
    return SizedBox(
      width: w,
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount:
              _foodController.foods[_controller.currentCategoryIndex].length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _controller.currentFoodIndex = index;
                _controller.currentCategoryIndex =
                    _tabController.currentIndex.value;
                Get.to(() => const DetailsPage());
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Center(
                      child: FadeInDown(
                        delay: const Duration(milliseconds: 1500),
                        child: Container(
                          width: w / 2.4,
                          height: h / 4,
                          decoration: BoxDecoration(
                              color: unSelectedColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                    Obx(() {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: FadeInDown(
                          delay: const Duration(milliseconds: 1600),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                // Adding shadow to the image
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Spin(
                              delay: const Duration(milliseconds: 1650),
                              child: Image.asset(
                                _foodController
                                    .foods[_tabController.currentIndex.value]
                                        [index]
                                    .img,
                                width: w / 3.5,
                                height: h / 7,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FadeInDown(
                                delay: const Duration(milliseconds: 1700),
                                child: Text(
                                  _foodController
                                      .foods[_tabController.currentIndex.value]
                                          [index]
                                      .title,
                                  style: GoogleFonts.oxygen(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                              ),
                              FadeInDown(
                                delay: const Duration(milliseconds: 1800),
                                child: Text(
                                  _foodController
                                      .foods[_tabController.currentIndex.value]
                                          [index]
                                      .subtitle,
                                  style: GoogleFonts.oxygen(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ),
                              FadeInDown(
                                delay: const Duration(milliseconds: 1900),
                                child: Text(
                                  "${_foodController.foods[_tabController.currentIndex.value][index].price.toStringAsFixed(2)} تومان ",
                                  style: GoogleFonts.oxygen(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    Positioned(
                      left: 5,
                      bottom: 5,
                      child: FadeInUp(
                        delay: const Duration(milliseconds: 1950),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: IconButton(
                              onPressed: () {
                                Get.find<WalletController>().add(
                                  id: _foodController
                                      .foods[_tabController.currentIndex.value]
                                          [index]
                                      .id,
                                  img: _foodController
                                      .foods[_tabController.currentIndex.value]
                                          [index]
                                      .img,
                                  title: _foodController
                                      .foods[_tabController.currentIndex.value]
                                          [index]
                                      .title,
                                  subtitle: _foodController
                                      .foods[_tabController.currentIndex.value]
                                          [index]
                                      .subtitle,
                                  price: _foodController
                                      .foods[_tabController.currentIndex.value]
                                          [index]
                                      .price,
                                );
                              },
                              icon: const Icon(
                                Icons.add,
                                color: unSelectedColor,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

/// Middle Salads PageView Widget Components
class MiddleSaladsPageView extends StatefulWidget {
  const MiddleSaladsPageView({
    Key? key,
  }) : super(key: key);

  @override
  State<MiddleSaladsPageView> createState() => _MiddleSaladsPageViewState();
}

class _MiddleSaladsPageViewState extends State<MiddleSaladsPageView> {
  @override
  Widget build(BuildContext context) {
    var _controller = Get.find<SwitchController>();
    var _tabController = Get.find<TabBarController>();
    var _foodController = Get.find<FoodController>();
    return SizedBox(
        height: h / 4.5,
        child: PageView.builder(
            controller: PageController(
              viewportFraction: 0.8,
            ),
            padEnds: false,
            itemCount:
                _foodController.foods[_controller.currentCategoryIndex].length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _controller.currentFoodIndex = index;
                  _controller.currentCategoryIndex =
                      _tabController.currentIndex.value;

                  Get.to(() => const DetailsPage());
                },
                child: SizedBox(
                  width: w / 1.3,
                  height: h / 5.5,
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FadeInLeft(
                        delay: const Duration(milliseconds: 900),
                        child: Container(
                          width: w / 1.5,
                          height: h / 5.5,
                          decoration: BoxDecoration(
                              color: unSelectedColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                    Obx(() {
                      return Positioned(
                        bottom: 15,
                        right: 10,
                        child: FadeInLeft(
                          delay: const Duration(milliseconds: 1000),
                          child: Spin(
                            delay: const Duration(milliseconds: 1100),
                            child: Container(
                              width: w / 3.5,
                              height: h / 5.2,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  // Adding shadow to the image
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Hero(
                                tag: _foodController
                                    .foods[_tabController.currentIndex.value]
                                        [index]
                                    .id,
                                child: Image.asset(
                                  _foodController
                                      .foods[_tabController.currentIndex.value]
                                          [index]
                                      .img,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return Positioned(
                        left: 40,
                        top: 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInDown(
                              delay: const Duration(milliseconds: 1200),
                              child: Text(
                                _foodController
                                    .foods[_tabController.currentIndex.value]
                                        [index]
                                    .title,
                                style: GoogleFonts.oxygen(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            FadeInDown(
                              delay: const Duration(milliseconds: 1300),
                              child: Text(
                                _foodController
                                    .foods[_tabController.currentIndex.value]
                                        [index]
                                    .subtitle,
                                textDirection: TextDirection.rtl,
                                style: GoogleFonts.oxygen(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              ),
                            ),
                            FadeInDown(
                              delay: const Duration(milliseconds: 1400),
                              child: Text(
                                "${_foodController.foods[_tabController.currentIndex.value][index].price.toStringAsFixed(2)} تومان",
                                style: GoogleFonts.oxygen(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    Positioned(
                      left: 5,
                      bottom: 10,
                      child: FadeInUp(
                          delay: const Duration(milliseconds: 1450),
                          child: DescribedFeatureOverlay(
                            featureId: 'add_item_feature_id',
                            // Unique id that identifies this overlay.
                            tapTarget: const CircleAvatar(
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.add,
                                  color: unSelectedColor,
                                )),

                            // The widget that will be displayed as the tap target.
                            title: const Text('افزودن غذا'),
                            description: const Text(
                                'با زدن این آیتم میتوانید غذای انتخابی را به لیست خرید خود اضافه کنید همچنین برای نمایش جزئیات بیشتر میتوانید روی کارت مربوط به غذای مورد نظر کلیک کنید'),
                            backgroundColor: Theme.of(context).primaryColor,
                            contentLocation: ContentLocation.above,
                            overflowMode: OverflowMode.wrapBackground,
                            onComplete: () async {
                              return true;
                            },
                            targetColor: Colors.orange.shade100,
                            textColor: Colors.white,
                            child: buildCircleAvatar(
                                _foodController, _tabController, index),
                          )),
                    ),
                  ]),
                ),
              );
            }));
  }

  CircleAvatar buildCircleAvatar(FoodController _foodController,
      TabBarController _tabController, int index) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      child: IconButton(
          onPressed: () {
            Get.find<WalletController>().add(
              id: _foodController
                  .foods[_tabController.currentIndex.value][index].id,
              img: _foodController
                  .foods[_tabController.currentIndex.value][index].img,
              title: _foodController
                  .foods[_tabController.currentIndex.value][index].title,
              subtitle: _foodController
                  .foods[_tabController.currentIndex.value][index].subtitle,
              price: _foodController
                  .foods[_tabController.currentIndex.value][index].price,
            );
          },
          icon: const Icon(
            Icons.add,
            color: unSelectedColor,
          )),
    );
  }
}

/// TabBar Widget Components
class TabBar extends StatelessWidget {
  TabBar({
    Key? key,
  }) : super(key: key);

  final List<String> tabNames = [
    "سالادها",
    "خوراک ها",
    "ماهی ها",
  ];

  @override
  Widget build(BuildContext context) {
    var _controller = Get.find<TabBarController>();
    return FadeInDown(
      delay: const Duration(milliseconds: 800),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 5),
        width: w,
        height: h / 13,
        child: ListView.builder(
            itemCount: tabNames.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return Obx(() {
                return GestureDetector(
                  onTap: () {
                    _controller.currentIndex.value = index;
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: w / tabNames.length,
                    height: double.infinity,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        _controller.currentIndex.value == index
                            ? Colors.deepOrange
                            : unSelectedColor,
                        _controller.currentIndex.value == index
                            ? Colors.orange
                            : unSelectedColor,
                      ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      tabNames[index],
                      style: GoogleFonts.oxygen(
                          color: _controller.currentIndex.value == index
                              ? Colors.white
                              : Colors.black38,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    )),
                  ),
                );
              });
            }),
      ),
    );
  }
}

/// Top Text Widget Components
class TopTextWidget extends StatelessWidget {
  static final topTexts = [
    "سالاد های خوشمزه ",
    "خوراک های مختلف",
    "انواع ماهی ها"
  ];
  static final subTexts = [
    "تهیه شده از مواد تازه و سالم",
    "با طعم ها و مزه های به یادماندنی",
    "از شمال ایران تا جنوب ایران"
  ];

  const TopTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Get.find<TabBarController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
              delay: const Duration(milliseconds: 400),
              child: Obx(() {
                return Text(
                  topTexts[_controller.currentIndex.value],
                  style: GoogleFonts.oxygen(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                  ),
                );
              })),
          FadeInDown(
            delay: const Duration(milliseconds: 600),
            child: Obx(() {
              return Text(
                subTexts[_controller.currentIndex.value],
                style: GoogleFonts.oxygen(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w300,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// MyAppBar Widget Components
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 100),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.black,
            size: 35,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 2),
              child: DescribedFeatureOverlay(
                featureId: 'profile_feature_id',
                tapTarget: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/me.jpg"),
                ),
                title: const Text('صفحه پروفایل'),
                description: const Text(
                    'با زدن بر روی عکس پروفایل خود میتوانید اطلاهات کاربری خود و اطلاعات مربوط به خرید های گذشته خود را ببینید'),
                backgroundColor: Theme.of(context).primaryColor,
                contentLocation: ContentLocation.below,
                completeDuration: const Duration(milliseconds: 100),
                onComplete: () async {
                  return true;
                },
                overflowMode: OverflowMode.wrapBackground,
                targetColor: Colors.orange.shade100,
                textColor: Colors.white,
                child: buildGestureDetector(),
              )),
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector() {
    return GestureDetector(
      onTap: () {
        Get.find<NavigatorController>().changeNavBarIndex(2);
      },
      child: const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage("assets/images/me.jpg"),
      ),
    );
  }
}
