import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import 'package:samit_kapoor/components/custom_page_route.dart';
import 'package:samit_kapoor/core/profile_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation? animation;
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animation = Tween<double>(begin: 800, end: -200).animate(
      CurvedAnimation(
          parent: animationController!, curve: Curves.fastOutSlowIn),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      animationController?.forward();
    });

    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      Navigator.of(context).pushReplacement(
        CustomPageRoute(
            child: const ProfileScreen(),
            transition: Transitions.slide,
            duration: const Duration(seconds: 2)),
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash_screen_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: animationController!,
            builder: (ctx, child) {
              return Positioned(top: animation!.value, child: child!);
            },
            child: SizedBox(
              width: Get.width,
              child: Lottie.asset(
                'assets/animations/rocket_launch.json',
                height: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
