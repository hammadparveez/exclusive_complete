import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/category_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/provider/wordpress_product_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/screen/cart/cart_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/widget/fancy_bottom_nav_bar.dart';
import 'package:sixvalley_ui_kit/view/screen/home/home_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/more/more_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/order/order_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/profile/profile_screen.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showDialog(
          context: context,
          builder: (_) {
            return Material(
              type: MaterialType.transparency,
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SpinKitCubeGrid(
                      color: ColorResources.WEB_PRIMARY_COLOR, size: 100),
                  SizedBox(height: 10),
                  Text("Please wait a sec...",
                      style: titilliumSemiBold.copyWith(
                          color: ColorResources.WHITE)),
                ]),
              ),
            );
          });
      if (Provider.of<AuthProvider>(context, listen: false).isInvalidAuth) {
        Provider.of<ProfileProvider>(context, listen: false).getAddressOfUser();
        await Provider.of<CartProvider>(context, listen: false).getCartData();
      }
      Get.back();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final categoryList = context.watch<CategoryProvider>().categoryList;
    final featureProducts =
        context.watch<WordPressProductProvider>().listOfFeaturedProducts;
    featureProducts.forEach((feature) {
      precacheImage(NetworkImage(feature.thumbnail_img.first), context);
    });
    categoryList.forEach((category) {
      precacheImage(NetworkImage(category.icon), context);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _screens = [
    HomePage(),
    //InboxScreen(isBackButtonExist: false),
    OrderScreen(isBacButtonExist: false),
    CartScreen(
        isBackButtonExist:
            false), //NotificationScreen(isBacButtonExist: false),
    MoreScreen(),
  ];

  final GlobalKey<FancyBottomNavBarState> _bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    int _pageIndex = 0;
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _bottomNavKey.currentState.setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        bottomNavigationBar: FancyBottomNavBar(
          key: _bottomNavKey,
          tabs: [
            FancyTabData(imagePath: Images.home_image, title: Strings.home),
            // FancyTabData(imagePath: Images.message_image, title: Strings.inbox),
            FancyTabData(
                imagePath: Images.shopping_image, title: Strings.orders),

            FancyTabData(
                imagePath: Images.cart_image /* Images.notification*/,
                title: "Cart" /*Strings.notification*/),
            FancyTabData(imagePath: Images.more_image, title: Strings.more),
          ],
          onTabChangedListener: (int index) {
            _pageController.jumpToPage(index);
            _pageIndex = index;
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }
}

class ProfilerRow extends StatefulWidget {
  @override
  _ProfilerRowState createState() => _ProfilerRowState();
}

class _ProfilerRowState extends State<ProfilerRow> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProfileProvider>(
      builder: (_, authProvider, profile, child) => Row(children: [
        InkWell(
            onTap: () {
              if (authProvider.isInvalidAuth) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProfileScreen()));
              }
            },
            child: authProvider.isUserLoggedIn
                ? profile.userInfoModel == null
                    ? CircleAvatar(child: Icon(Icons.person, size: 35))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                              "${authProvider.getUserDisplayName().characters.first.toUpperCase()}"),
                        ),
                      )
                : CircleAvatar(
                    child: Icon(Icons.person, size: 35, color: Colors.black),
                    backgroundColor: Colors.white,
                  )),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        Text(authProvider.getUserDisplayName().toUpperCase(),
            /*authProvider.isUserLoggedIn
                ? profile.userInfoModel != null
                    ? '${profile.userInfoModel.fName} ${profile.userInfoModel.lName}'
                    : 'Full Name'
                : 'Guest',*/
            style: titilliumRegular.copyWith(color: ColorResources.WHITE)),
      ]),
    );
  }
}
