import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';

class PrivacPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(title: "About Exclusive Boutique"),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Privacy Policy",
                        style: titilliumBold.copyWith(
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 15)),
                  ),
                  Text(
                      """ These Website Terms supplement (and are in addition to) the terms of our Privacy Policy. Our Privacy Policy explains what personal information we collect about you when you use the Website, and you can view our Privacy Policy online by clicking here . Please note that when you agree to these general terms and conditions of sale (“General Terms and Conditions of Sale”), they apply to any order you place through the exclusive website at www.exclusiveinn.com/new (the “Website”). You must read these General Terms and Conditions of Sale carefully. By placing an order through the Website, you confirm that you have read, understood and agreed to these General Terms and Conditions of Sale in their entirety. If you do not agree to these General Terms and Conditions of Sale in their entirety, you must not order any product or service through the Website. By agreeing to these Website Terms, you shall be deemed also to have read, understood and agreed to our Privacy Policy in its entirety.""",
                      style: titilliumSemiBold.copyWith(
                          color: Colors.black54,
                          fontSize:
                              MediaQuery.textScaleFactorOf(context) * 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
