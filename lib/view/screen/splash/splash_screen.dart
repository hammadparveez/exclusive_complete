import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/provider/splash_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/onboarding/onboarding_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/splash/widget/splash_painter.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  Tween<double> _tween = Tween<double>(begin: 80, end: 280);

  @override
  void initState() {
    super.initState();

    //firebaseToken();
    /* _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animation = _tween.animate(_animationController);
    _animation.addListener(() {
      setState(() {});
    });
    _animationController.repeat(reverse: true);*/
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SplashProvider>(context, listen: false).initSharedPrefData();
      Provider.of<CartProvider>(context, listen: false).initTotalCartCount();
      Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
      Provider.of<ProfileProvider>(context, listen: false).getHomeAddress();
      Provider.of<SplashProvider>(context, listen: false)
          .initConfig()
          .then((bool isSuccess) {
        if (isSuccess) {
          Timer(Duration(milliseconds: 1500), () async {
            //sharedPerf.setBool("onBoardSeen", true);
            final sharedPerf = await SharedPreferences.getInstance();
            if (sharedPerf.getBool("onBoardSeen") != null) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => DashBoardScreen()));
            } else {
              sharedPerf.setBool("onBoardSeen", true);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => OnBoardingScreen()));
            }
            /* if (Provider.of<AuthProvider>(context, listen: false)
                .isLoggedIn()) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => DashBoardScreen()));
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => OnBoardingScreen(
                      indicatorColor: ColorResources.GREY,
                      selectedIndicatorColor: ColorResources.COLOR_PRIMARY)));*/
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: ColorResources.WHITE,
            child: CustomPaint(
              painter: SplashPainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 280,
                  child: Image.asset('assets/images/exclusive_logo.png',
                      fit: BoxFit.cover),
                ),
                SizedBox(height: 15),
                CircularProgressIndicator(
                  //strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }
}
