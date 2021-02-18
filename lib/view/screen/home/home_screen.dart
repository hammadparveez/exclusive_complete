import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/helper/product_type.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/category_provider.dart';
import 'package:sixvalley_ui_kit/provider/network_check_notifier.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/provider/wordpress_product_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/animated_custom_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/request_time_out_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/title_row.dart';
import 'package:sixvalley_ui_kit/view/screen/auth/auth_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/cart/cart_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/category/all_category_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/home/widget/banners_view.dart';
import 'package:sixvalley_ui_kit/view/screen/home/widget/category_view.dart';
import 'package:sixvalley_ui_kit/view/screen/home/widget/products_view.dart';
import 'package:sixvalley_ui_kit/view/screen/more/more_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/more/widget/app_info_dialog.dart';
import 'package:sixvalley_ui_kit/view/screen/search/search_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as loader;
Future myTopLevelBg(Map<String, dynamic> message) async {
  print("This is my top level function $message");
  //return 0;
}

class FireBaseTest {
  static Future<dynamic> bgMethod(_) {
    print("Back ground messaging");
    return Future.value("Some stuff");
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
  AnimationController _animationController;
  Animation<Offset> _animation ;
  Tween<Offset> _tween;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _tween = Tween(begin: Offset(0, 0), end: Offset(Get.width, Get.height));
    _animation = _tween.animate(_animationController);
    //After the build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     // showDialog(context: context, builder:(_) => loader.SpinKitFoldingCube(color: ColorResources.PRIMARY_COLOR_BIT_DARK));
      Provider.of<CategoryProvider>(context, listen: false).initCategoryList();
      Provider.of<WordPressProductProvider>(context, listen: false)
          .initFeaturedProducts();

      //final firebase = FirebaseMessaging();

      // firebase.configure(
      //   onMessage: (Map<String, dynamic> message) {
      //     firebase.subscribeToTopic("weather");
      //     print('onMessage called: $message');
      //     Get.to(CartScreen());
      //   },
      //   onResume: (Map<String, dynamic> message) {
      //     print('onResume called: $message');
      //   },
      //   onLaunch: (Map<String, dynamic> message) {
      //     print('onLaunch called: $message');
      //   },
      //   onBackgroundMessage: myTopLevelBg,
      // );
      //final value = await firebase.getToken();
      //print("My Firebase Notification token ${value}");
      /*  firebase.subscribeToTopic("order_done").then((value) => print("Order is done "), onError: () {print("An error occured ");});
      firebase.subscribeToTopic("awesome_boy");*/
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //_animationController.reset();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     /* showDialog(context: context, builder:(_) {
        return
        Material(
          type: MaterialType.transparency,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                loader.SpinKitCubeGrid(color: ColorResources.WEB_PRIMARY_COLOR, size: 100),
                SizedBox(height: 10),
                Text("Please wait a sec...", style: titilliumSemiBold.copyWith(color: ColorResources.WHITE)),
              ]),
          ),
        );
        });*/
      if (context.read<CategoryProvider>().isInternet) {
        showDialog(
            context: context,
            child: NoInterNetDialog(singleBack: true),
            barrierDismissible: false);
      } else if (context.read<CategoryProvider>().isTimedOut) {
        showDialog(
            context: context,
            child: RequestTimedOutDialog(singleBack: true),
            barrierDismissible: false);
      }
    });

    return RefreshIndicator(
      displacement: Get.height * .1,
      onRefresh: () async {
        final categoryProvider =
            Provider.of<CategoryProvider>(context, listen: false);
        final wordPressProvider =
            Provider.of<WordPressProductProvider>(context, listen: false);
        final networkNotifier =
            Provider.of<NetworkCheckNotifier>(context, listen: false);
        await networkNotifier.checkInternet();
        if (networkNotifier.isNoInternet) {
          showDialog(
              context: context,
              child: NoInterNetDialog(singleBack: true),
              barrierDismissible: false);
          Provider.of<CartProvider>(context, listen: false)
              .initTotalCartCount();
          categoryProvider.initCategoryList();
          wordPressProvider.initFeaturedProducts();
        } else if (networkNotifier.isTimedOut) {
          showDialog(
              context: context,
              child: RequestTimedOutDialog(singleBack: true),
              barrierDismissible: false);
          Provider.of<CartProvider>(context, listen: false)
              .initTotalCartCount();
          categoryProvider.initCategoryList();
          wordPressProvider.initFeaturedProducts();
        } else {
          Provider.of<CartProvider>(context, listen: false)
              .initTotalCartCount();
          if (categoryProvider.categoryList.isEmpty)
            categoryProvider.initCategoryList();
          if (wordPressProvider.listOfFeaturedProducts.isEmpty)
            wordPressProvider.initFeaturedProducts();
        }
        return true;
      },
      child: Scaffold(
        key: _drawerKey,
        backgroundColor: Colors.grey[50],
        //resizeToAvoidBottomPadding: false,

        //drawer: Transform.translate(offset: _animation.value, child: _CustomDrawer()),

        body: Stack(
          children: [
            Transform(transform: Matrix4.translationValues(Get.width/2, Get.height/2, 30), child: _CustomDrawer()),
            Transform.translate(
              offset: -_animation.value,
              child: SafeArea(
                child: CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  //physics: Bouncin  gScrollPhysics(),
                  slivers: [
                    // App Bar
                    SliverAppBar(
                      leading: IconButton(
                        icon: Icon(Icons.notes),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            _animationController.animateTo(Get.height-100);
                          });
                       _animationController.forward();}
                        //  _drawerKey.currentState.openDrawer(); }
                      ),
                      floating: true,
                      elevation: 0,
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: ColorResources.WHITE,
                      title: Image.asset(Images.company_logo_big, height: 45),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => CartScreen()));
                          },
                          icon: Stack(overflow: Overflow.visible, children: [
                            Image.asset(
                              Images.cart_arrow_down_image,
                              height: Dimensions.ICON_SIZE_DEFAULT,
                              width: Dimensions.ICON_SIZE_DEFAULT,
                              color: ColorResources.PRIMARY_COLOR,
                            ),
                            Consumer<CartProvider>(
                              builder: (_, cartsProvider, child) => Positioned(
                                top: -4,
                                right: -4,
                                child: CircleAvatar(
                                  radius: 7,
                                  backgroundColor: ColorResources.RED,
                                  child: Text(
                                      cartsProvider.totalItemsInCart.toString(),
                                      style: titilliumSemiBold.copyWith(
                                        color: ColorResources.WHITE,
                                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      )),
                                ),
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),

                    // Search Button
                    SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverDelegate(
                            child: InkWell(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SearchScreen())),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL,
                                vertical: 2),
                            color: ColorResources.WHITE,
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              height: 50,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: ColorResources.GREY,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.PADDING_SIZE_SMALL),
                              ),
                              child: Row(children: [
                                Icon(Icons.search,
                                    color: ColorResources.PRIMARY_COLOR,
                                    size: Dimensions.ICON_SIZE_LARGE),
                                SizedBox(width: 5),
                                Text(Strings.SEARCH_HINT,
                                    style: robotoRegular.copyWith(
                                        color: ColorResources.HINT_TEXT_COLOR)),
                              ]),
                            ),
                          ),
                        ))),

                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                            child: BannersView(),
                          ),

                          // Category

                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                Dimensions.PADDING_SIZE_SMALL,
                                20,
                                Dimensions.PADDING_SIZE_SMALL,
                                Dimensions.PADDING_SIZE_SMALL),
                            child: TitleRow(
                                title: Strings.CATEGORY,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AllCategoryScreen()));
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL),
                            child: CategoryView(
                              isHomePage: true,
                            ),
                          ),

                          // Top Products
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                Dimensions.PADDING_SIZE_SMALL,
                                20,
                                Dimensions.PADDING_SIZE_SMALL,
                                Dimensions.PADDING_SIZE_SMALL),
                            child: TitleRow(title: Strings.latest_products),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL),
                            child: ProductView(
                                productType: ProductType.LATEST_PRODUCT,
                                scrollController: _scrollController),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}

class _CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProfileProvider>(
        builder: (_, authProvider, profileProvider, child) {
      print(authProvider.getUserDisplayName());
      return Container(
        width: MediaQuery.of(context).size.width,
        color: ColorResources.WHITE,
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Container(
                  color: Colors.black87,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(Images.company_logo_big,
                            height: 60, color: ColorResources.WHITE),
                      ),
                      ProfilerRow(),
                      /*Row(
                        children: [
                          profileProvider.userInfoModel != null
                              ? CircleAvatar(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                        profileProvider.userInfoModel.image,
                                        width: 35,
                                        height: 35),
                                  ),
                                )
                              : CircleAvatar(
                                  child: Icon(Icons.person,
                                      size: 35, color: Colors.black),
                                  backgroundColor: Colors.white,
                                ),
                          const SizedBox(width: 10),
                          Text(
                            "${authProvider.getUserEmail()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.FONT_SIZE_LARGE),
                          ),
                        ],
                      ),*/
                    ],
                  ),
                ),
              ),

              /*Container(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                    ),
                    const SizedBox(height: 8),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("example@exmaple.com"),
                    ),
                  ],
                ),
                color: Colors.purple,
              ),*/
              // Buttons

              TitleButton(
                  image: Images.more_filled_image,
                  title: Strings.all_category,
                  navigateTo: AllCategoryScreen()),
              /* TitleButton(
                  image: Images.notification_filled,
                  title: Strings.notification,
                  navigateTo: NotificationScreen()),*/
              TitleButton(
                  image: Images.cart_image,
                  title: Strings.CART,
                  navigateTo: CartScreen()),

              /* TitleButton(
                  image: Images.chats,
                  title: Strings.chats,
                  navigateTo: InboxScreen()),*/
              TitleButton(
                  image: Images.settings,
                  title: Strings.settings,
                  navigateTo: MoreScreen()),

              /*    TitleButton(
                  image: Images.help_center,
                  title: Strings.help_center,
                  navigateTo: HelpCenterScreen()),
              TitleButton(
                  image: Images.preference,
                  title: Strings.support_ticket,
                  navigateTo: SupportTicketScreen()),*/

              //ListTile(onTap: () {}, title: Text("My Orders")),
              /* TitleButton(
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
                  navigateTo: TermsAndConditions()),*/

              ListTile(
                leading: Image.asset(Images.logo_image,
                    width: 25,
                    height: 25,
                    fit: BoxFit.fill,
                    color: ColorResources.PRIMARY_COLOR),
                title: Text(Strings.app_info,
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE)),
                onTap: () =>
                    showAnimatedDialog(context, AppInfoDialog(), isFlip: true),
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
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.black87),
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
            ],
          ),
        ),
      );
    });
  }
}
