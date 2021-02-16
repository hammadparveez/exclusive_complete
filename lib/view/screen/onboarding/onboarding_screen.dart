import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/onboarding_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;

  OnBoardingScreen({
    this.indicatorColor = Colors.grey,
    this.selectedIndicatorColor = Colors.black,
  });

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OnBoardingProvider>(context, listen: false)
          .initBoardingList();
    });

    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(Images.background, fit: BoxFit.fill),
          ),
          Consumer<OnBoardingProvider>(
            builder: (context, onboardingList, child) => Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    itemCount: onboardingList.onBoardingList.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Image.asset(onboardingList
                                    .onBoardingList[index].imageUrl)),
                            Text(onboardingList.onBoardingList[index].title,
                                style: titilliumBold.copyWith(
                                    fontSize: 30, color: ColorResources.BLACK)),
                            Text(
                                onboardingList
                                    .onBoardingList[index].description,
                                textAlign: TextAlign.center,
                                style: titilliumRegular),
                          ],
                        ),
                      );
                    },
                    onPageChanged: (index) {
                      onboardingList.changeSelectIndex(index);
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _pageIndicators(
                              onboardingList.onBoardingList, context),
                        ),
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(left: 70, right: 70),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(colors: [
                              ColorResources.COLOR_PRIMARY,
                              ColorResources.COLOR_PRIMARY,
                              ColorResources.COLOR_PRIMARY,
                            ])),
                        child: FlatButton(
                          onPressed: () {
                            if (Provider.of<OnBoardingProvider>(context,
                                        listen: false)
                                    .selectedIndex ==
                                onboardingList.onBoardingList.length - 1) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => DashBoardScreen()));
                            } else {
                              _pageController.animateToPage(
                                  Provider.of<OnBoardingProvider>(context,
                                              listen: false)
                                          .selectedIndex +
                                      1,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                                onboardingList.selectedIndex ==
                                        onboardingList.onBoardingList.length - 1
                                    ? Strings.GET_STARTED
                                    : Strings.NEXT,
                                style: titilliumSemiBold.copyWith(
                                    color: ColorResources.WHITE,
                                    fontSize: Dimensions.FONT_SIZE_LARGE)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _pageIndicators(var onBoardingList, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < onBoardingList.length; i++) {
      _indicators.add(
        Container(
          width: i == Provider.of<OnBoardingProvider>(context).selectedIndex
              ? 18
              : 7,
          height: 7,
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == Provider.of<OnBoardingProvider>(context).selectedIndex
                ? ColorResources.COLOR_PRIMARY
                : ColorResources.WHITE,
            borderRadius:
                i == Provider.of<OnBoardingProvider>(context).selectedIndex
                    ? BorderRadius.circular(50)
                    : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}
