import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/app_category_provider.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/billing_address_provider.dart';
import 'package:sixvalley_ui_kit/provider/brand_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/category_provider.dart';
import 'package:sixvalley_ui_kit/provider/chat_provider.dart';
import 'package:sixvalley_ui_kit/provider/coupon_provider.dart';
import 'package:sixvalley_ui_kit/provider/customer_provider.dart';
import 'package:sixvalley_ui_kit/provider/net_checker_provider.dart';
import 'package:sixvalley_ui_kit/provider/network_check_notifier.dart';
import 'package:sixvalley_ui_kit/provider/notification_provider.dart';
import 'package:sixvalley_ui_kit/provider/onboarding_provider.dart';
import 'package:sixvalley_ui_kit/provider/order_provider.dart';
import 'package:sixvalley_ui_kit/provider/payment_type_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/provider/search_provider.dart';
import 'package:sixvalley_ui_kit/provider/seller_provider.dart';
import 'package:sixvalley_ui_kit/provider/splash_provider.dart';
import 'package:sixvalley_ui_kit/provider/support_ticket_provider.dart';
import 'package:sixvalley_ui_kit/provider/tracking_provider.dart';
import 'package:sixvalley_ui_kit/provider/variation_provider.dart';
import 'package:sixvalley_ui_kit/provider/wishlist_provider.dart';
import 'package:sixvalley_ui_kit/provider/wordpress_product_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/view/screen/splash/splash_screen.dart';

import 'di_container.dart' as di;
import 'provider/banner_provider.dart';
import 'provider/mega_deal_provider.dart';
import 'provider/product_details_provider.dart';
import 'provider/product_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<CategoryProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<InternetCheckerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<MegaDealProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BrandProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<PaymentTypeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BannerProvider>()),
      ChangeNotifierProvider(create: (context) => VariationProvider()),
      ChangeNotifierProvider(create: (context) => CustomerProvider()),
      ChangeNotifierProvider(create: (context) => BillingAddressProvider()),
      ChangeNotifierProvider(
          create: (context) => di.sl<ProductDetailsProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OnBoardingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SellerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<AppCategoriesProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<WordPressProductProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WishListProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<NetworkCheckNotifier>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<SupportTicketProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TrackingProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Exclusive Inn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorResources.PRIMARY_MATERIAL,
        primaryColor: ColorResources.PRIMARY_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
