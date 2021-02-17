import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/redirect_check.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/screen/auth/widget/sign_in_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/auth/widget/sign_up_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';

class AuthScreen extends StatelessWidget {
  final RedirectionCheck redirect;
  AuthScreen({this.redirect});
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = false;
    final PageController _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isLoggedIn =
          Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
      Provider.of<ProfileProvider>(context, listen: false)
          .initAddressTypeList();
      Provider.of<AuthProvider>(context, listen: false).isRemember;
    });

    return Scaffold(
      body: isLoggedIn
          ? DashBoardScreen()
          : Stack(
              overflow: Overflow.visible,
              children: [
                // for background
                Image.asset(Images.background,
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width),

                Consumer<AuthProvider>(
                  builder: (context, auth, child) => SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),

                        // for logo with text
                        Image.asset(Images.company_logo_big,
                            height: 150, width: 200),

                        // for decision making section like signin or register section
                        Padding(
                          padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_LARGE),
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              Positioned(
                                bottom: 0,
                                right: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                left: 0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  //margin: EdgeInsets.only(right: Dimensions.FONT_SIZE_LARGE),
                                  height: 1,
                                  color: ColorResources.GAINS_BORO,
                                ),
                              ),
                              Consumer<AuthProvider>(
                                builder: (context, authProvider, child) => Row(
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          _pageController.animateToPage(0,
                                              duration:
                                                  Duration(milliseconds: 700),
                                              curve: Curves.easeInOut),
                                      child: Column(
                                        children: [
                                          Text(Strings.SIGN_IN,
                                              style:
                                                  authProvider.selectedIndex ==
                                                          0
                                                      ? titilliumSemiBold
                                                      : titilliumRegular),
                                          Container(
                                            height: 1,
                                            width: 40,
                                            margin: EdgeInsets.only(top: 8),
                                            color: authProvider.selectedIndex ==
                                                    0
                                                ? ColorResources.COLOR_PRIMARY
                                                : Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 25),
                                    InkWell(
                                      onTap: () =>
                                          _pageController.animateToPage(1,
                                              duration: Duration(seconds: 1),
                                              curve: Curves.easeInOut),
                                      child: Column(
                                        children: [
                                          Text(Strings.SIGN_UP,
                                              style:
                                                  authProvider.selectedIndex ==
                                                          1
                                                      ? titilliumSemiBold
                                                      : titilliumRegular),
                                          Container(
                                              height: 1,
                                              width: 50,
                                              margin: EdgeInsets.only(top: 8),
                                              color: authProvider
                                                          .selectedIndex ==
                                                      1
                                                  ? ColorResources.COLOR_PRIMARY
                                                  : Colors.transparent),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // show login or register widget
                        Expanded(
                          child: Consumer<AuthProvider>(
                            builder: (context, authProvider, child) =>
                                PageView.builder(
                              itemCount: 2,
                              controller: _pageController,
                              itemBuilder: (context, index) {
                                if (authProvider.selectedIndex == 0) {
                                  return SignInWidget(redirect: redirect);
                                } else {
                                  return SignUpWidget();
                                }
                              },
                              onPageChanged: (index) {
                                authProvider.updateSelectedIndex(index);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
