import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';

class AboutUs extends StatelessWidget {
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
                    child: Text("About Us",
                        style: titilliumBold.copyWith(
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 15)),
                  ),
                  Text(
                      """ Since 1993, Exclusive Inn is helping women feel proud of their dressing choices. We have helped thousands of women over a span of more than 20 years in redefining their suiting choices and bringing their festive dressings to the latest trends.
With an eye to detail and uncompromised watch to fabric quality, Exclusive Inn is working in Pakistan to offer a one-of-its kind Pakistani fashion boutique environment. Be it Pakistani boutique bridals dresses, party wear, designer wear or festive suiting, we have the best team that will provide you the best and most stylish dresses available in the market at the best prices!
Our aim is to help women be happy in carrying their dresses. Your happiness is our ultimate objective! We design dresses to help you stay comfortable, look fashionable, seem elegant and have an undeniable class with your clothing. At Exclusive Inn, your clothing choices are exclusive and not mass-produced, unlike other boutiques in the market.""",
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
