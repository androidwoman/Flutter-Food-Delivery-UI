import 'package:animate_do/animate_do.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

//
import '../controllers/switch_controller.dart';
import '../controllers/wallet_controller.dart';
import '../utils/constanst.dart';
import '../controllers/food_controller.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: DescribedFeatureOverlay(
          featureId: 'add_item_details_feature_id',
          // Unique id that identifies this overlay.
          tapTarget: const SizedBox(
              height: 70,
              width: 70,
              child: Icon(
                LineIcons.shoppingCart,
                color: Colors.white,
                size: 40,
              )),
          // The widget that will be displayed as the tap target.
          title: const Text('افزودن غذا'),
          description: const Text(
              'با زدن این آیتم میتوانید غذای انتخابی را به لیست خرید خود اضافه کنید '),
          backgroundColor: Theme.of(context).primaryColor,
          contentLocation: ContentLocation.above,
          overflowMode: OverflowMode.wrapBackground,
          onComplete: () async {
            return true;
          },
          targetColor: Colors.orange.shade100,
          textColor: Colors.white,
          child: const MyFAB(),
        ),
        appBar: const MyAppBar(),
        body: const Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                TopImage(),
                HeaderWidget(),
                MiddleDescription(),
                DeliveryTime(),
                BottomPrice()
              ],
            ),
          ),
        ));
  }
}

/// Bottom Price Widget Components
class BottomPrice extends StatelessWidget {
  const BottomPrice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Get.find<SwitchController>();
    return FadeInDown(
      delay: const Duration(milliseconds: 1300),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: const EdgeInsets.only(
            top: 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                LineIcons.dollarSign,
                color: Colors.grey.shade700,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "هزینه نهایی",
                style: GoogleFonts.oxygen(
                  color: Colors.grey.shade700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${Get.find<FoodController>().foods[_controller.currentCategoryIndex][_controller.currentFoodIndex].price.toStringAsFixed(2)} تومان ",
                style: GoogleFonts.oxygen(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Delivery Time Widget Components
class DeliveryTime extends StatelessWidget {
  const DeliveryTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Get.find<SwitchController>();
    return FadeInDown(
      delay: const Duration(milliseconds: 1100),
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: w,
        height: h / 22,
        child: Row(
          children: [
            Icon(
              LineIcons.clock,
              color: Colors.grey.shade700,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "زمان ارسال",
              style: GoogleFonts.oxygen(
                color: Colors.grey.shade700,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              Get.find<FoodController>()
                  .foods[_controller.currentCategoryIndex]
                      [_controller.currentFoodIndex]
                  .deliveryTime,
              style: GoogleFonts.oxygen(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Middle Description Widget Components
class MiddleDescription extends StatelessWidget {
  const MiddleDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Get.find<SwitchController>();
    return FadeInDown(
      delay: const Duration(milliseconds: 900),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        width: w,
        height: h / 6,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              Get.find<FoodController>()
                  .foods[_controller.currentCategoryIndex]
                      [_controller.currentFoodIndex]
                  .description,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
            )),
      ),
    );
  }
}

/// My Custom FloatingActionButton
class MyFAB extends StatelessWidget {
  const MyFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _foodController = Get.find<FoodController>();
    var _controller = Get.find<SwitchController>();
    return SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Get.find<WalletController>().add(
            id: _foodController
                .foods[_controller.currentCategoryIndex]
                    [_controller.currentFoodIndex]
                .id,
            img: _foodController
                .foods[_controller.currentCategoryIndex]
                    [_controller.currentFoodIndex]
                .img,
            title: _foodController
                .foods[_controller.currentCategoryIndex]
                    [_controller.currentFoodIndex]
                .title,
            subtitle: _foodController
                .foods[_controller.currentCategoryIndex]
                    [_controller.currentFoodIndex]
                .subtitle,
            price: _foodController
                .foods[_controller.currentCategoryIndex]
                    [_controller.currentFoodIndex]
                .price,
          );
        },
        child: const Icon(
          LineIcons.shoppingCart,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}

/// Header Widget Components - Blow Top Image
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Get.find<SwitchController>();

    return SizedBox(
      width: w,
      height: h / 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInDown(
            delay: const Duration(milliseconds: 300),
            child: SizedBox(
              width: w / 1.6,
              child: Text(
                Get.find<FoodController>()
                    .foods[_controller.currentCategoryIndex]
                        [_controller.currentFoodIndex]
                    .title,
                style: GoogleFonts.oxygen(
                  fontSize: Get.find<FoodController>()
                              .foods[_controller.currentCategoryIndex]
                                  [_controller.currentFoodIndex]
                              .title
                              .length <=
                          13
                      ? 26
                      : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Top Image Widget Components
class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Get.find<SwitchController>();
    return Spin(
      delay: const Duration(milliseconds: 200),
      child: Container(
        width: w,
        height: h / 2.3,
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
            tag: Get.find<FoodController>()
                .foods[_controller.currentCategoryIndex]
                    [_controller.currentFoodIndex]
                .id,
            child: Image.asset(
              Get.find<FoodController>()
                  .foods[_controller.currentCategoryIndex]
                      [_controller.currentFoodIndex]
                  .img,
            )),
      ),
    );
  }
}

/// AppBar Components
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 100),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
      ),
    );
  }
}
