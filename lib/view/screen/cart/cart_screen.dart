import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_scroll_loader.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_screen.dart';
import 'package:sixvalley_ui_kit/view/basewidget/not_loggedin_widget.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/screen/cart/widget/cart_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/checkout/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final bool fromCheckout;
  final List<CartModel> checkoutCartList;
  final isBackButtonExist;
  CartScreen(
      {this.fromCheckout = false,
      this.checkoutCartList,
      this.isBackButtonExist = true});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalAmount = 0;
  List<bool> selectedList = [];
  List<CartModel> cartList = [];
  bool isAuth = true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (Provider.of<AuthProvider>(context, listen: false).isInvalidAuth) {
        Provider.of<CartProvider>(context, listen: false).isLoading = true;
        Provider.of<CartProvider>(context, listen: false).resetCart();
        Provider.of<CartProvider>(context, listen: false).getCartData();
        Provider.of<CartProvider>(context, listen: false).initTotalCartCount();
        cartList
            .addAll(Provider.of<CartProvider>(context, listen: false).cartList);
      } else {
        print("You are not signed in");
      }
      selectedList =
          Provider.of<CartProvider>(context, listen: false).isSelectedList;
      if (widget.fromCheckout) {
        cartList.addAll(widget.checkoutCartList);
      } else {
        print(
            "My Cart List ${Provider.of<CartProvider>(context, listen: false).cartList}");
        Provider.of<CartProvider>(context, listen: false)
            .cartList
            .forEach((element) {
          totalAmount += element.price;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("My Cart List Length ${cartList.length}");
    List<String> sellerList = [];
    List<List<CartModel>> cartProductList = [];
    List<List<int>> cartProductIndexList = [];
    cartList.forEach((cart) {
      if (!sellerList.contains(cart.seller)) {
        sellerList.add(cart.seller);
      }
    });
    sellerList.forEach((seller) {
      List<CartModel> cartLists = [];
      List<int> indexList = [];
      cartList.forEach((cart) {
        if (seller == cart.seller) {
          cartLists.add(cart);
          indexList.add(cartList.indexOf(cart));
        }
      });
      cartProductList.add(cartLists);
      cartProductIndexList.add(indexList);
    });

    return WillPopScope(
      onWillPop: () async {
        Provider.of<ProductDetailsProvider>(context, listen: false)
            .resetQuantity();
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: Consumer<AuthProvider>(
            builder: (_, authProvider, child) => !authProvider.isInvalidAuth
                ? Column(children: [NotLoggedInWidget()])
                : !widget.fromCheckout
                    ? Container(
                        height: 60,
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_LARGE,
                            vertical: Dimensions.PADDING_SIZE_DEFAULT),
                        decoration: BoxDecoration(
                          color: ColorResources.COLOR_PRIMARY,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                        ),
                        child: Consumer<CartProvider>(
                          builder: (_, cartProvider, child) => cartProvider
                                      .cartList.length >
                                  0
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                      /*   InkWell(
                          onTap: () =>
                              Provider.of<CartProvider>(context, listen: false)
                                  .toggleAllSelect(),
                          child: Container(
                            width: 15,
                            height: 15,
                            margin: EdgeInsets.only(
                                right: Dimensions.PADDING_SIZE_SMALL),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: ColorResources.WHITE, width: 1)),
                            child:
                                Provider.of<CartProvider>(context).isAllSelect
                                    ? Icon(Icons.done,
                                        color: ColorResources.WHITE,
                                        size: Dimensions.ICON_SIZE_EXTRA_SMALL)
                                    : SizedBox.shrink(),
                          ),
                        ),
                        Text(Strings.all,
                            style: titilliumRegular.copyWith(
                                color: ColorResources.WHITE)),
*/
                                      //$ dollar All
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                        cartProvider.cartList.length > 0
                                            ? "${cartProvider.cartList.first.priceSymbol} ${cartProvider.amount}"
                                            : "Nothing In cart",
                                        /* PriceConverter.convertPrice(
                              context, Provider.of<CartProvider>(context).amount)*/

                                        style: titilliumSemiBold.copyWith(
                                            color: ColorResources.WHITE),
                                      ))),

                                      Builder(
                                        builder: (context) => RaisedButton(
                                          onPressed: () {
                                            List<CartModel> cartList = [];
                                            for (int i = 0;
                                                i <
                                                    Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .isSelectedList
                                                        .length;
                                                i++) {
                                              if (Provider.of<CartProvider>(
                                                      context,
                                                      listen: false)
                                                  .isSelectedList[i]) {
                                                cartList.add(
                                                    Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .cartList[i]);
                                              }
                                            }
                                            if (cartList.length > 0) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          CheckoutScreen(
                                                              cartList:
                                                                  cartList)));
                                            } else {
                                              showCustomSnackBar(
                                                  'Select at least one product.',
                                                  context);
                                            }
                                          },
                                          color: ColorResources.WHITE,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(Strings.checkout,
                                              style: titilliumSemiBold.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_SMALL,
                                                color: ColorResources
                                                    .COLOR_PRIMARY,
                                              )),
                                        ),
                                      ),
                                    ])
                              : const SizedBox.shrink(),
                        ),
                      )
                    : const SizedBox.shrink()),
        body: Consumer2<CartProvider, AuthProvider>(
            builder: (_, cartProvider, authProvider, child) {
          return Column(children: [
            CustomAppBar(
                title: Strings.CART,
                isBackButtonExist: widget.isBackButtonExist),
            !authProvider.isInvalidAuth
                ? NotLoggedInWidget()
                : CustomLoader(isLoading: cartProvider.isLoading, elseWidget:
                     cartProvider.cartList.length != 0
                        ? Consumer<CartProvider>(
                            builder: (context, carProvider, child) {
                              print(
                                  "List View Builder ${cartProvider.cartList.length}");
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      await Provider.of<CartProvider>(context,
                                              listen: false)
                                          .getCartData();
                                      return true;
                                    },
                                    color: ColorResources.PRIMARY_COLOR,
                                    child: ListView.builder(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(
                                              parent: BouncingScrollPhysics()),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(0),
                                      itemCount: cartProvider.cartList
                                          .length, //cartProductList[index].length,
                                      itemBuilder: (context, i) => CartWidget(
                                        key: UniqueKey(),
                                        cartModel: cartProvider.cartList[i],
                                        index: 0, //cart[i],
                                        fromCheckout: widget.fromCheckout,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )

                        /*ListView.builder(
                    itemCount: cartProvider.cartList.length,
                    padding: EdgeInsets.all(0),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: Dimensions.PADDING_SIZE_LARGE),
                        child: Column(children: [
                          Container(
                            padding:
                                EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
                            decoration: BoxDecoration(
                                color: ColorResources.WHITE,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3)),
                                ]),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Seller",
                                      textAlign: TextAlign.start,
                                      style: titilliumRegular),
                                  Text("" */ /*sellerList[index]*/ /*,
                                      textAlign: TextAlign.end,
                                      style: titilliumSemiBold.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_LARGE,
                                        color: ColorResources.COLOR_PRIMARY,
                                      )),
                                ]),
                          ),

                        ]),
                      );
                    },
                  )*/
                        : Expanded(
                            child: NoInternetOrDataScreen(isNoInternet: false))
              ),
          ]);
        }),
      ),
    );
  }
}
