import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/customer_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/animated_custom_dialog.dart';
import 'package:sixvalley_ui_kit/view/screen/auth/auth_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/cart/cart_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/more/widget/app_info_dialog.dart';
import 'package:sixvalley_ui_kit/view/screen/order/order_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/privacy/about.dart';
import 'package:sixvalley_ui_kit/view/screen/privacy/privacy.dart';
import 'package:sixvalley_ui_kit/view/screen/privacy/term_condition.dart';
import 'package:sixvalley_ui_kit/view/screen/profile/profile_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/search/search_screen.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isGuestMode = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isGuestMode =
          !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
      // Provider.of<AuthProvider>(context, listen: false).getUserDisplayName();
    });

    return Scaffold(
      body: Consumer2<AuthProvider, CustomerProvider>(
        builder: (_, authProvider, customerProvider, child) => Stack(children: [
          // Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              Images.more_page_header,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),

          // AppBar
          Positioned(
            top: Get.context.mediaQueryPadding.top + 8,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL,
            child: Consumer2<ProfileProvider, AuthProvider>(
              builder: (context, profile, authProvider, child) {
                print("${authProvider.getUserID()}");
                return Row(children: [
                  Image.asset(Images.company_logo_big,
                      height: 45, color: ColorResources.WHITE),
                  Expanded(child: SizedBox.shrink()),
                  Text(
                      authProvider.isInvalidAuth
                          ? authProvider.getUserDisplayName()
                          : "Guest",
                      style: titilliumRegular.copyWith(
                          color: ColorResources.WHITE)),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  InkWell(
                      onTap: () {
                        if (authProvider.isInvalidAuth) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProfileScreen()));
                          /*showCustomModalDialog(
                            context,
                            title: Strings.THIS_SECTION_IS_LOCK,
                            content: Strings.GOTO_LOGIN_SCREEN_ANDTRYAGAIN,
                            cancelButtonText: Strings.CANCEL,
                            submitButtonText: Strings.LOGIN,
                            submitOnPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => AuthScreen()));
                            },
                            cancelOnPressed: () => Navigator.of(context).pop(),
                          );
                        } else {
                          final isLoggedIn =
                              Provider.of<AuthProvider>(context, listen: false)
                                  .isLoggedIn();
                          debugPrint("is User is logged In ${isLoggedIn}");
                          if (isLoggedIn) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfileScreen()));*/
                          //}
                        }
                      },
                      child: authProvider.isUserLoggedIn
                          ? Hero(
                              tag: 'profile-icon',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: customerProvider
                                            .wordPressCustomerModel !=
                                        null
                                    ? CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.network(
                                            "${customerProvider.wordPressCustomerModel.avatar_url}") /*Text(
                                          "${authProvider.getUserDisplayName().characters.first.toUpperCase()}"),*/
                                        )
                                    : CircleAvatar(
                                        child: Icon(Icons.person,
                                            size: 35, color: Colors.black),
                                        backgroundColor: Colors.white,
                                      ),
                              ),
                            )
                          : CircleAvatar(
                              child: Icon(Icons.person,
                                  size: 35, color: Colors.black),
                              backgroundColor: Colors.white,
                            )),
                ]);
              },
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 120),
            decoration: BoxDecoration(
              color: ColorResources.ICON_BG,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                // Top Row Items
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SquareButton(
                          image: Images.shopping_image,
                          title: Strings.orders,
                          navigateTo: OrderScreen()),
                      SquareButton(
                          image: Images.cart_image,
                          title: Strings.CART,
                          navigateTo: CartScreen()),
                      /*SquareButton(
                          image: Images.offers,
                          title: Strings.offers,
                          navigateTo: OffersScreen()),*/
                      SquareButton(
                          image: "assets/images/search_icon.png",
                          title: Strings.SEARCH,
                          navigateTo: SearchScreen()),
                    ]),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                // Buttons
                /*TitleButton(
                    image: Images.more_filled_image,
                    title: Strings.all_category,
                    navigateTo: AllCategoryScreen()),*/
                /* TitleButton(
                  image: Images.notification_filled,
                  title: Strings.notification,
                  navigateTo: NotificationScreen()),*/
                /*        TitleButton(
                    image: Images.cart_image,
                    title: Strings.CART,
                    navigateTo: CartScreen()),*/

                /* TitleButton(
                  image: Images.chats,
                  title: Strings.chats,
                  navigateTo: InboxScreen()),*/
                /*  TitleButton(
                  image: Images.settings,
                  title: Strings.settings,
                  navigateTo: settings.SettingsScreen()),*/

                /*    TitleButton(
                  image: Images.help_center,
                  title: Strings.help_center,
                  navigateTo: HelpCenterScreen()),
              TitleButton(
                  image: Images.preference,
                  title: Strings.support_ticket,
                  navigateTo: SupportTicketScreen()),*/

                //ListTile(onTap: () {}, title: Text("My Orders")),
                TitleButton(
                    image: "assets/images/about-512.png",
                    title: "About ExclusiveInn",
                    navigateTo: AboutUs()),
                TitleButton(
                    image: "assets/images/policy.png",
                    title: "Privacy & Policy",
                    navigateTo: PrivacPolicy()),
                TitleButton(
                    image: "assets/images/130-512.png",
                    title: "Terms & Conditions",
                    navigateTo: TermsAndConditions()),

                ListTile(
                  leading: Image.asset(Images.logo_image,
                      width: 25,
                      height: 25,
                      fit: BoxFit.fill,
                      color: ColorResources.PRIMARY_COLOR),
                  title: Text(Strings.app_info,
                      style: titilliumRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  onTap: () => showAnimatedDialog(context, AppInfoDialog(),
                      isFlip: true),
                ),
                TitleButton(
                    image: Images.signout_image,
                    title: !authProvider.isUserLoggedIn
                        ? "Sign In"
                        : Strings.sign_out,
                    onTap: () async {
                      //Provider.of<AuthProvider>(context, listen: false).signOut();

                      if (authProvider.isLoggedIn()) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Column(
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          Colors.black87),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("Signing out...")
                                  ],
                                ),
                              );
                            });

                        Future.delayed(Duration(seconds: 2), () async {
                          Navigator.pop(context);
                          Provider.of<ProfileProvider>(context, listen: false)
                              .nullifyAddressList();
                          print("Nullified");
                          await authProvider.signOut();
                          Provider.of<CartProvider>(context, listen: false)
                              .clearTotalItemsInCart();
                        });
                      } else {

                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AuthScreen()));
                      }
                    }),

                TitleButton(
                    image: "assets/images/exit-512.png",
                    title: "Quit",
                    onTap: () => SystemNavigator.pop(animated: true)),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;

  SquareButton(
      {@required this.image, @required this.title, @required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 100;
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Container(
          width: width / 4,
          height: width / 4,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorResources.PRIMARY_COLOR,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200], spreadRadius: 3, blurRadius: 10)
            ],
          ),
          child: Image.asset(image, color: ColorResources.WHITE),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title, style: titilliumRegular),
        ),
      ]),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  final VoidCallback onTap;
  TitleButton(
      {@required this.image,
      @required this.title,
      @required this.navigateTo,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image,
          width: 25,
          height: 25,
          fit: BoxFit.fill,
          color: ColorResources.PRIMARY_COLOR),
      title: Text(title,
          style:
              titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: onTap != null
          ? onTap
          : () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => navigateTo),
              ),
    );
  }
}
