import 'package:animate_do/animate_do.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//
import '../pages/landscape_mode.dart';
import '../controllers/splash_controller.dart';
import '../utils/constanst.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {

        FeatureDiscovery.discoverFeatures(
          context,
          const <String>{
            // Feature ids for every feature that you want to showcase in order.
            'profile_feature_id',
            'add_item_feature_id',
            'add_item_details_feature_id'
          },
        );

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      Get.find<SplashController>();
      return Scaffold(
        body: SizedBox(
          width: w,
          height: h,
          child: Stack(children: [
            FadeInDown(
              delay: const Duration(milliseconds: 100),
              child: Container(
                width: w,
                height: h / 2,
                decoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(1000),
                        bottomLeft: Radius.circular(1000))),
              ),
            ),
            Positioned(
              top: 90,
              left: 60,
              child: FadeInDown(
                delay: const Duration(milliseconds: 800),
                child: SizedBox(
                  width: w / 1.5,
                  height: h / 10,
                  child: Center(
                    child: Text(
                      "فود سنتر",
                      style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 60,
              child: FadeInDown(
                delay: const Duration(milliseconds: 1200),
                child: SizedBox(
                  width: w / 1.5,
                  height: h / 10,
                  child: Center(
                    child: Text(
                      "اپلیکیشن سفارش آنلاین غذا",
                      style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 220,
              left: 75,
              child: FadeInDown(
                delay: const Duration(milliseconds: 1600),
                child: Spin(
                  delay: const Duration(milliseconds: 2000),
                  child: SizedBox(
                    width: w / 1.6,
                    height: h / 3.3,
                    child: Center(child: Image.asset('assets/images/11.png')),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 80,
              child: FadeInDown(
                delay: const Duration(milliseconds: 2300),
                child: SizedBox(
                  width: w / 1.6,
                  height: h / 19,
                  child: Center(
                    child: Text(
                      "لطفا چند لحظه صبر کنید .... ",
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 175,
              child: FadeInUp(
                delay: const Duration(milliseconds: 2600),
                child: SizedBox(
                  width: w / 5,
                  height: h / 15,
                  child: Center(
                      child: SpinKitFoldingCube(
                    size: 35,
                    itemBuilder: (BuildContext context, int index) {
                      return const DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                        ),
                      );
                    },
                  )),
                ),
              ),
            ),
          ]),
        ),
      );
    } else {
      return const LandScape();
    }
  }
}
