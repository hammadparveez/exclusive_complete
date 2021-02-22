import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/not_loggedin_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/cart/cart_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/cart_bottom_sheet.dart';

class BottomCartView extends StatefulWidget {
  final Product product;
  final WordPressProductModel wordPressProductModel;
  BottomCartView({@required this.product, this.wordPressProductModel});

  @override
  _BottomCartViewState createState() => _BottomCartViewState();
}

class _BottomCartViewState extends State<BottomCartView> {
  int count = 0;
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    print(
        "Total Carts are Product ${widget.wordPressProductModel.name}  ${Provider.of<CartProvider>(context).totalItemsInCart.toString()}");
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: Colors.grey[300], blurRadius: 10, spreadRadius: 3)
        ],
      ),
      child: Row(children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Stack(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  child: Image.asset(Images.cart_image,
                      color: ColorResources.PRIMARY_COLOR),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 17,
                    width: 17,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.COLOR_PRIMARY,
                    ),
                    child: Text(
                      "${Provider.of<CartProvider>(context).totalItemsInCart}",
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: ColorResources.WHITE),
                    ),
                  ),
                )
              ]),
            )),
        /* Expanded(
            flex: 6,
            child: InkWell(
              onTap: () {
                print("I'm Tapped ${widget.wordPressProductModel}");
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      if (authProvider.isInvalidAuth)
                        return CartBottomSheet(
                            incCounter: incCounter,
                            counter: count,
                            wordPressProductModel: widget.wordPressProductModel,
                            product: widget.product,
                            isBuy: true,
                            callback: () {});
                      else
                        return SizedBox();
                      return SizedBox(
                          height: Get.height * .8, child: NotLoggedInWidget());
                    });
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(left: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 2, color: ColorResources.COLOR_PRIMARY),
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.WHITE,
                ),
                child: Text(
                  Strings.buy_now,
                  style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: ColorResources.COLOR_PRIMARY),
                ),
              ),
            )),*/
        Expanded(
            flex: 11,
            child: InkWell(
              onTap: () {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                if (!Provider.of<CartProvider>(context, listen: false)
                    .isAddedInCart(2 /*product.id*/)) {
                  if (authProvider.isInvalidAuth)
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (con) {
                          print(
                              "User Logged In or not Hammad ${authProvider.isInvalidAuth}");

                          return CartBottomSheet(
                              product: widget.product,
                              wordPressProductModel:
                                  widget.wordPressProductModel,
                              isBuy: false,
                              callback: () {
                                /*showCustomSnackBar(
                                    'Adding to the cart', context,
                                    isError: false);*/
                              });
                        });
                  else {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Scaffold(
                                    body: Column(
                                  children: [
                                    NotLoggedInWidget(),
                                  ],
                                ))));
                  }
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(Strings.already_added),
                      backgroundColor: ColorResources.RED));
                }
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.COLOR_PRIMARY,
                ),
                child: Text(
                  Provider.of<CartProvider>(context).isAddedInCart(2)
                      ? Strings.added_to_cart
                      : Strings.add_to_cart,
                  style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: ColorResources.WHITE),
                ),
              ),
            )),
      ]),
    );
  }

  incCounter() {
    setState(() {
      count++;
    });
  }
}
