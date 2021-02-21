import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/payment_gateway_model.dart';
import 'package:sixvalley_ui_kit/data/model/redirect_check.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_customer_model.dart';
import 'package:sixvalley_ui_kit/data/shipping_update_model.dart' as ship;
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/coupon_provider.dart';
import 'package:sixvalley_ui_kit/provider/order_provider.dart';
import 'package:sixvalley_ui_kit/provider/payment_type_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/amount_widget.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_scroll_loader.dart';
import 'package:sixvalley_ui_kit/view/basewidget/not_loggedin_widget.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/title_row.dart';
import 'package:sixvalley_ui_kit/view/screen/auth/auth_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/cart/cart_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/checkout/widget/address_bottom_sheet.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/order/order_screen.dart';

extension ToShowOrHide on BuildContext {
  toShowOrHide(dynamic shippingUpdateModel) {
    if (shippingUpdateModel != null) {}
  }
}

class CheckoutScreen extends StatefulWidget {
  final List<CartModel> cartList;
  final bool fromProductDetails;
  CheckoutScreen({@required this.cartList, this.fromProductDetails = false});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  double _order = 0;
  double _discount = 0;
  double _tax = 0;
  String countryCode = "";
  BillingAddressModel billingAddressModel;
  String paymentTitle = "";

  toShowOrHide(dynamic shippingUpdateModel) {
    if (shippingUpdateModel != null)
      return true;
    else
      return false;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isInvalidAuth) {
        final profileProvider =
            Provider.of<ProfileProvider>(context, listen: false);
        Provider.of<ProfileProvider>(context, listen: false).resetAddressList();
        profileProvider.isAddingAddressLoader = true;
        await profileProvider.getAddressOfUser();
        Provider.of<OrderProvider>(context, listen: false).setAddressIndex(0);
/*        profileProvider.fetchRegion().then( (value) {
          try {
            if (profileProvider.countryModel != null &&
                profileProvider.countryModel is Map) {
              countryCode = profileProvider.countryModel.keys.firstWhere((key) {
                if (profileProvider.addressList.first.country ==
                    profileProvider.countryModel[key]) {
                  return true;
                } else {
                  return false;
                }
              });
            }
            profileProvider.countrySelectedCode = countryCode;
            profileProvider.updateShipping(countryCode: countryCode);
            profileProvider.updateShipping(countryCode: countryCode);
            if (profileProvider.addressList.length > 0 &&
                profileProvider.addressList.first.address_1.isNotEmpty)

            print(
                "Sheeply Model  ${profileProvider.shippingUpdateModel.totals.currencyCode}");
          } catch (error) {
            print("Country not found ${error}");
            profileProvider.isShippingLoaded = false;
          } finally {
            profileProvider.isAddingAddressLoader = false;
          }
        });*/
        await profileProvider.fetchPaymentRegion();
        profileProvider.updateShipping(
            countryCode: profileProvider.countrySelectedCode);
        profileProvider.updateShipping(
            countryCode: profileProvider.countrySelectedCode);
      } else {
        print("User is not logged in");
        Provider.of<ProfileProvider>(context, listen: false).clearAddressList();
        Get.to(Scaffold(body: NotLoggedInWidget()));
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
        isLoading: Provider.of<ProfileProvider>(context).isAddingAddressLoader,
        isExpanded: false,
        elseWidget: Scaffold(
            key: _scaffoldKey,
            //resizeToAvoidBottomPadding: true,
            bottomNavigationBar:
                Consumer<ProfileProvider>(builder: (_, profileProvider, child) {
              if (!profileProvider.isAddingAddressLoader) {
                print("+++++ ${profileProvider.countrySelectedCode} ++++");
                if (profileProvider.addressList == null)
                  return buildAddressTopbar(context);
                else if (profileProvider.addressList.isEmpty)
                  return buildAddressTopbar(context);
                else
                  return profileProvider.shippingUpdateModel != null &&
                          profileProvider.shippingUpdateModel.shippingRates !=
                              null &&
                          profileProvider
                              .shippingUpdateModel.shippingRates.isNotEmpty
                      ? profileProvider.shippingUpdateModel.shippingRates.first
                              .shippingRates.isNotEmpty
                          ? Container(
                              height: 60,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_LARGE,
                                  vertical: Dimensions.PADDING_SIZE_DEFAULT),
                              decoration: BoxDecoration(
                                  color: ColorResources.COLOR_PRIMARY,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10))),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Consumer2<OrderProvider, ProfileProvider>(
                                      builder: (context, order, profileProvider,
                                          child) {
                                        double totalAmount = 0;
                                        for (int i = 0;
                                            i < widget.cartList.length;
                                            i++)
                                          totalAmount +=
                                              widget.cartList[i].price;

                                        double _shippingCost =
                                            order.shippingIndex != null
                                                ? double.parse(order
                                                    .shippingList[
                                                        order.shippingIndex]
                                                    .cost)
                                                : 0;
                                        double _couponDiscount =
                                            Provider.of<CouponProvider>(context)
                                                        .discount !=
                                                    null
                                                ? Provider.of<CouponProvider>(
                                                        context)
                                                    .discount
                                                : 0;
                                        return Text(
                                          profileProvider.shippingUpdateModel !=
                                                  null
                                              ? "${profileProvider.shippingUpdateModel.totals.currencyCode} ${profileProvider.shippingUpdateModel.totals.totalPrice}"
                                              : "",
                                          /*  PriceConverter.convertPrice(
                      context,
                      (_order +
                          _shippingCost -
                          _discount -
                          _couponDiscount +
                          _tax)),*/
                                          style: titilliumSemiBold.copyWith(
                                              color: ColorResources.WHITE),
                                        );
                                      },
                                    ),
                                    !Provider.of<OrderProvider>(context)
                                            .isLoading
                                        ? Consumer<ProfileProvider>(
                                            builder:
                                                (_, profileProvider, child) =>
                                                    Builder(
                                              builder: (context) =>
                                                  RaisedButton(
                                                onPressed: () async {
                                                  print(
                                                      "Country is ${profileProvider.countryName}");
                                                  print(
                                                      "Payment Gatewaye is:  ${profileProvider.paymentGatewayTitle}");
                                                  print(
                                                      "Shipping model is :  ${profileProvider.shippingUpdateModel}");
                                                  /*final countryProvider = Provider.of<ProfileProvider>(
                              context,
                              listen: false);*/
                                                  final orderProvider = Provider
                                                      .of<OrderProvider>(
                                                          context,
                                                          listen: false);

                                                  final authProvider =
                                                      Provider.of<AuthProvider>(
                                                          context,
                                                          listen: false);
                                                  if (authProvider
                                                      .isInvalidAuth) {
                                                    print("Is User Logged In");
                                                    final userId = authProvider
                                                        .getUserID();
                                                    final paymentTypeProvider =
                                                        Provider.of<
                                                                PaymentTypeProvider>(
                                                            context,
                                                            listen: false);
                                                    print(
                                                        "My Address List is Seeing ${profileProvider.addressList}");
                                                    if (profileProvider
                                                            .addressList ==
                                                        null) {
                                                      showCustomSnackBar(
                                                          'You are not signed in',
                                                          context);
                                                    } else if (orderProvider
                                                                .addressIndex ==
                                                            null ||
                                                        profileProvider
                                                            .addressList
                                                            .isEmpty) {
                                                      showCustomSnackBar(
                                                          'Select a shipping address',
                                                          context);
                                                    } else {
                                                      print(
                                                          "My Payment Method ${profileProvider.paymentGatewaySelectedValue}");
                                                      if (profileProvider
                                                              .paymentGatewaySelectedValue ==
                                                          null) {
                                                        showDialog(
                                                            barrierDismissible:
                                                                false,
                                                            context: context,
                                                            builder: (_) {
                                                              return WillPopScope(
                                                                onWillPop:
                                                                    () async =>
                                                                        false,
                                                                child:
                                                                    AlertDialog(
                                                                  content: Text(
                                                                      "Payment Method must be selected"),
                                                                ),
                                                              );
                                                            });
                                                        await Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    1700),
                                                            () => Get.back());
                                                      } else {
                                                        showDialog(
                                                            barrierDismissible:
                                                                false,
                                                            context: context,
                                                            builder: (_) {
                                                              return Center(
                                                                  child:
                                                                      CircularProgressIndicator());
                                                            });
                                                        final orderDone =
                                                            await Provider.of<
                                                                        OrderProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .makeOrder(
                                                          userID: userId,
                                                          paymentType:
                                                              profileProvider
                                                                  .paymentGatewaySelectedValue,
                                                          cartModel:
                                                              widget.cartList,
                                                          countryModel:
                                                              profileProvider
                                                                  .countryName,
                                                          billingAddressModel:
                                                              profileProvider
                                                                  .addressList
                                                                  .first,
                                                          paymentTitle:
                                                              profileProvider
                                                                  .paymentGatewayTitle,
                                                          selectedCountryCode:
                                                              profileProvider
                                                                  .countrySelectedCode,
                                                          shippingUpdateModel:
                                                              profileProvider
                                                                  .shippingUpdateModel,
                                                        );
                                                        if (orderDone) {
                                                          for (CartModel item
                                                              in widget
                                                                  .cartList) {
                                                            print(
                                                                "Cart Item Model Keys ${item.itemKey}");
                                                            await Provider.of<
                                                                        CartProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .removeFromCart(
                                                                    0,
                                                                    itemRemovingKey:
                                                                        item.itemKey);
                                                          }
                                                          Provider.of<CartProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .initTotalCartCount();
                                                          Get.back();
                                                          Get.off(OrderScreen(
                                                            isOrderDone: true,
                                                          ));
                                                        } else {
                                                          Get.back();

                                                          showCustomSnackBar(
                                                              "Your order failed to proceed",
                                                              context);
                                                        }
                                                      }
                                                    }
                                                  } else {
                                                    authProvider
                                                        .isFromSomeWhere = true;
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) => AuthScreen(
                                                              redirect:
                                                                  RedirectionCheck
                                                                      .isCheckout),
                                                        ));
                                                  }

                                                  /*else {
                            List<Cart> carts = [];
                            widget.cartList.forEach(
                              (cart) => carts.add(
                                Cart(
                                  cart.id.toString(),
                                  cart.tax.toInt(),
                                  cart.quantity,
                                  cart.price.toInt(),
                                  cart.discount.toInt(),
                                  cart.discountType,
                                  0,
                                ),*/
                                                },
                                                color: ColorResources.WHITE,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(Strings.proceed,
                                                    style: titilliumSemiBold
                                                        .copyWith(
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_EXTRA_SMALL,
                                                      color: ColorResources
                                                          .COLOR_PRIMARY,
                                                    )),
                                              ),
                                            ),
                                          )
                                        : CircularProgressIndicator(),
                                  ]),
                            )
                          : const SizedBox.shrink()
                      : const SizedBox();
              } else {
                return const SizedBox();
              }
            }),
            //: const SizedBox.shrink()

            body: !Provider.of<ProfileProvider>(context).isShippingLoaded
                ? Column(
                    children: [
                      CustomAppBar(title: Strings.checkout),
                      Consumer<ProfileProvider>(
                          builder: (_, profileProvider, child) {
                        bool isAddressEmpty =
                            profileProvider.addressList.isEmpty;
                        print(
                            "CartList Images are: ${widget.cartList[widget.cartList.length - 1].image}");
                        print(
                            "Is my Address Empt or not ${profileProvider.shippingUpdateModel}");
                        int index = 0;
                        final orderProvider =
                            Provider.of<OrderProvider>(context, listen: false);
                        if (orderProvider.addressIndex != null)
                          index = orderProvider.addressIndex;

                        return Expanded(
                          child: ListView(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.all(0),
                              children: [
                                // Shipping Details
                                Container(
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  decoration: BoxDecoration(
                                      color: ColorResources.WHITE),
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(Strings.SHIPPING_TO,
                                              style: titilliumRegular),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () => showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  builder: (context) =>
                                                      AddressBottomSheet()),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        profileProvider
                                                                    .addressList
                                                                    .isNotEmpty &&
                                                                profileProvider
                                                                    .addressList
                                                                    .first
                                                                    .address_1
                                                                    .isNotEmpty &&
                                                                profileProvider
                                                                    .addressList
                                                                    .first
                                                                    .country
                                                                    .isNotEmpty
                                                            ? Provider.of<OrderProvider>(
                                                                        context)
                                                                    .isSelected
                                                                ? profileProvider.addressList[
                                                                            index] !=
                                                                        null
                                                                    ? "${profileProvider.addressList[index].address_1} ${profileProvider.addressList[index].city} ${profileProvider.addressList[index].state} ${profileProvider.addressList[index].country} ${profileProvider.addressList[index].postcode}"
                                                                    : "You are not signed in"
                                                                        "Address is ..."
                                                                : ""
                                                            : Strings
                                                                .add_your_address,
                                                        style: titilliumRegular
                                                            .copyWith(
                                                                fontSize: Dimensions
                                                                    .FONT_SIZE_SMALL),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    Image.asset(Images.EDIT_TWO,
                                                        width: 15,
                                                        height: 15,
                                                        color: ColorResources
                                                            .PRIMARY_COLOR_BIT_DARK),
                                                  ]),
                                            ),
                                          ),
                                        ]),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: Divider(
                                          height: 2,
                                          color:
                                              ColorResources.HINT_TEXT_COLOR),
                                    ),
                                    /*  Row(children: [
                          Expanded(
                              child: Text(Strings.SHIPPING_PARTNER,
                                  style: titilliumRegular)),
                          Expanded(
                            child: InkWell(
                              onTap: () => showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      ShippingMethodBottomSheet()),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      Provider.of<OrderProvider>(context)
                                                  .shippingIndex ==
                                              null
                                          ? Strings.select_shipping_method
                                          : Provider.of<OrderProvider>(context,
                                                  listen: false)
                                              .shippingList[
                                                  Provider.of<OrderProvider>(
                                                          context,
                                                          listen: false)
                                                      .shippingIndex]
                                              .title,
                                      style: titilliumSemiBold.copyWith(
                                          color: ColorResources.COLOR_PRIMARY),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                        width:
                                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    Image.asset(Images.EDIT_TWO,
                                        width: 15, height: 15),
                                  ]),
                            ),
                          ),
                        ]),*/
                                  ]),
                                ),

                                // Order Details
                                Container(
                                  margin: EdgeInsets.only(
                                      top: Dimensions.PADDING_SIZE_SMALL),
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  color: ColorResources.WHITE,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleRow(
                                            title: Strings.ORDER_DETAILS,
                                            onTap: widget.fromProductDetails
                                                ? null
                                                : () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) => CartScreen(
                                                                fromCheckout:
                                                                    true,
                                                                checkoutCartList:
                                                                    widget
                                                                        .cartList)));
                                                  }),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              Dimensions.PADDING_SIZE_SMALL),
                                          child: Row(children: [
                                            if (widget
                                                        .cartList[widget
                                                                .cartList
                                                                .length -
                                                            1]
                                                        .image !=
                                                    null &&
                                                widget
                                                    .cartList[
                                                        widget.cartList.length -
                                                            1]
                                                    .image
                                                    .isNotEmpty)
                                              CachedNetworkImage(
                                                imageUrl: widget
                                                    .cartList[
                                                        widget.cartList.length -
                                                            1]
                                                    .image,
                                                fit: BoxFit.fill,
                                                width: 50,
                                                height: 50,
                                                errorWidget: (_, value, e) {
                                                  return Image.asset(
                                                      "assets/product_images/not-available.jpg");
                                                },
                                              )
                                            else
                                              const SizedBox.shrink(),
                                            SizedBox(
                                                width: Dimensions
                                                    .MARGIN_SIZE_DEFAULT),
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.cartList[0].name,
                                                      style: titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_EXTRA_SMALL,
                                                          color: ColorResources
                                                              .PRIMARY_COLOR),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .MARGIN_SIZE_EXTRA_SMALL),
                                                    Row(children: [
                                                      /*     Text(
                                            profileProvider
                                                        .shippingUpdateModel !=
                                                    null
                                                ? "${profileProvider.shippingUpdateModel.totals.currencyCode} ${profileProvider.shippingUpdateModel.totals.totalPrice} "
                                                : "${widget.cartList[0].priceSymbol} ${widget.cartList[0].price}",
                                            */ /*PriceConverter.convertPrice(
                                                context,
                                                double.parse(widget
                                                    .cartList[0].price
                                                    .toString())),*/ /*
                                            style: titilliumSemiBold.copyWith(
                                                color: ColorResources
                                                    .COLOR_PRIMARY),
                                          ),
                                          SizedBox(
                                              width: Dimensions
                                                  .PADDING_SIZE_SMALL),*/
                                                      Text(
                                                          "x${widget.cartList[0].quantity} QTY"
                                                              .toString(),
                                                          style: titilliumSemiBold
                                                              .copyWith(
                                                                  color: ColorResources
                                                                          .colorMap[
                                                                      500])),
                                                      SizedBox(
                                                          width: Dimensions
                                                              .PADDING_SIZE_SMALL),
                                                      /*  Text(
                                              "${widget.cartList[0].variant.toUpperCase()}"
                                                  .toString(),
                                              style: titilliumSemiBold.copyWith(
                                                  color: ColorResources
                                                      .colorMap[500])),*/
                                                      /*Container(
                                            height: 20,
                                            width: 50,
                                            margin: EdgeInsets.only(
                                                left: Dimensions
                                                    .MARGIN_SIZE_EXTRA_LARGE),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                    color: ColorResources
                                                        .COLOR_PRIMARY)),
                                            child: Text(
                                              '${widget.cartList[0].discount ~/ (widget.cartList[0].price / 100)}% OFF',
                                              style: titilliumRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_SMALL,
                                                  color: ColorResources
                                                      .colorMap[500]),
                                            ),
                                          ),*/
                                                    ]),
                                                  ]),
                                            ),
                                          ]),
                                        ),

                                        // Coupon
                                        /* Row(children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: TextField(
                                      controller: _controller,
                                      decoration: InputDecoration(
                                        hintText: 'Have a coupon?',
                                        hintStyle: titilliumRegular.copyWith(
                                            color:
                                                ColorResources.HINT_TEXT_COLOR),
                                        filled: true,
                                        fillColor: ColorResources.ICON_BG,
                                        border: InputBorder.none,
                                      )),
                                ),
                              ),
                              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                              !Provider.of<CouponProvider>(context).isLoading
                                  ? RaisedButton(
                                      onPressed: () {
                                        if (_controller.text.isNotEmpty) {
                                          double value =
                                              Provider.of<CouponProvider>(context,
                                                      listen: false)
                                                  .initCoupon();
                                          if (value > 0) {
                                            _scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'You got ${PriceConverter.convertPrice(context, value)} discount'),
                                                    backgroundColor:
                                                        ColorResources.GREEN));
                                          } else {
                                            _scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Failed to get discount'),
                                                    backgroundColor:
                                                        ColorResources.RED));
                                          }
                                        }
                                      },
                                      color: ColorResources.GREEN,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(Strings.APPLY),
                                    )
                                  : CircularProgressIndicator(),
                            ]),*/
                                      ]),
                                ),

                                /*  Column(
                      children: [
                        TitleRow(title: "Variations"),
                        for (int i = 0;
                            i < widget.cartList[0].listOfVariation.length;
                            i++)
                          Column(
                            children: [
                              AmountWidget(
                                  title:
                                      "${widget.cartList[0].listOfVariation[i]}",
                                  amount: ""),
                            ],
                          ),
                      ],
                    ),*/

                                // Total bill
                                Container(
                                  margin: EdgeInsets.only(
                                      top: Dimensions.PADDING_SIZE_SMALL),
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  color: ColorResources.WHITE,
                                  child: Consumer<OrderProvider>(
                                    builder: (context, order, child) {
                                      double totalItemsAmount = 0;
                                      if (profileProvider.shippingUpdateModel !=
                                          null) {
                                        for (ship.ShippingUpdateModelItem item
                                            in profileProvider
                                                .shippingUpdateModel.items) {
                                          totalItemsAmount += double.parse(
                                              item.totals.lineSubtotal);
                                        }
                                      }
                                      double totalAmount = 0;
                                      for (int i = 0;
                                          i < widget.cartList.length;
                                          i++)
                                        totalAmount += widget.cartList[i].price;
                                      double _shippingCost = order
                                                  .shippingIndex !=
                                              null
                                          ? double.parse(order
                                              .shippingList[order.shippingIndex]
                                              .cost)
                                          : 0;
                                      double _couponDiscount =
                                          Provider.of<CouponProvider>(context)
                                                      .discount !=
                                                  null
                                              ? Provider.of<CouponProvider>(
                                                      context)
                                                  .discount
                                              : 0;

                                      return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            profileProvider
                                                        .shippingUpdateModel ==
                                                    null
                                                ? Center(
                                                    child: Text(
                                                        "Country/Address is not available",
                                                        style:
                                                            titilliumSemiBold))
                                                : const SizedBox(),
                                            TitleRow(title: Strings.TOTAL),
                                            AmountWidget(
                                                title: Strings.ORDER,
                                                amount: !isAddressEmpty
                                                    ? profileProvider
                                                                .shippingUpdateModel !=
                                                            null
                                                        ? "${profileProvider.shippingUpdateModel.totals.currencyCode} ${totalItemsAmount}"
                                                        : ""
                                                    : ""),
                                            /* PriceConverter.convertPrice(
                                        context, _order)),*/
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(Strings.SHIPPING_FEE,
                                                        style: titilliumRegular
                                                            .copyWith(
                                                                fontSize: Dimensions
                                                                    .FONT_SIZE_SMALL)),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            !isAddressEmpty
                                                                ? profileProvider.shippingUpdateModel !=
                                                                            null &&
                                                                        profileProvider.shippingUpdateModel.shippingRates !=
                                                                            null
                                                                    ? Text(profileProvider
                                                                            .shippingUpdateModel
                                                                            .shippingRates
                                                                            .first
                                                                            .shippingRates
                                                                            .isNotEmpty
                                                                        ? " ${profileProvider.shippingUpdateModel.shippingRates.first.shippingRates.first.name} ${profileProvider.shippingUpdateModel.shippingRates.first.shippingRates.first.price == 0.toString() ? "" : profileProvider.shippingUpdateModel.shippingRates.first.shippingRates.first.currencyCode + " " + profileProvider.shippingUpdateModel.shippingRates.first.shippingRates.first.price}"
                                                                        : "Shipping not available")
                                                                    : const SizedBox
                                                                        .shrink()
                                                                : const SizedBox
                                                                    .shrink(),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    /*     profileProvider
                                                        .countryMethodModel
                                                        .isNotEmpty
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: profileProvider
                                                            .countryMethodModel
                                                            .map<Widget>((e) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                  "${e.title}"),
                                                              Radio(
                                                                groupValue:
                                                                    profileProvider
                                                                        .groupRadioValue,
                                                                value:
                                                                    e.methodId,
                                                                onChanged:
                                                                    (value) {
                                                                  profileProvider
                                                                          .groupRadioValue =
                                                                      value;
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        }).toList(),
                                                      )
                                                    : const SizedBox.shrink(),*/
                                                    //Text(amount, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                                                  ]),
                                              /* AmountWidget(
                                  title: Strings.SHIPPING_FEE,
                                  amount:
                                      "${widget.cartList[0].shipping_required == null || widget.cartList[0].shipping_required == false ? 'Free Shipping' : 'Shipping Fee Required'}", */ /*PriceConverter.convertPrice(
                                        context, _shippingCost)*/
                                            ),
                                            /*AmountWidget(
                                    title: Strings.DISCOUNT,
                                    amount: PriceConverter.convertPrice(
                                        context, _discount)),*/
                                            /* AmountWidget(
                                    title: Strings.coupon_voucher,
                                    amount: PriceConverter.convertPrice(
                                        context, _couponDiscount)),*/
                                            /*   AmountWidget(
                                  title: Strings.TAX,
                                  amount:
                                      "${widget.cartList[0].taxable ? 'Tax charged required' : '${widget.cartList[0].priceSymbol} 0'}", */ /*PriceConverter.convertPrice(
                                        context, _tax)*/ /*
                                ),*/
                                            Divider(
                                                height: 5,
                                                color: ColorResources
                                                    .HINT_TEXT_COLOR),
                                            AmountWidget(
                                              title: Strings.TOTAL_PAYABLE,
                                              amount: !isAddressEmpty
                                                  ? profileProvider
                                                              .shippingUpdateModel !=
                                                          null
                                                      ? "${profileProvider.shippingUpdateModel.totals.currencyCode} ${profileProvider.shippingUpdateModel.totals.totalPrice}"
                                                      : ""
                                                  : "", /*PriceConverter.convertPrice(
                                        context,
                                        (_order +
                                            _shippingCost -
                                            _discount +
                                            _tax))*/
                                            ),
                                          ]);
                                    },
                                  ),
                                ),

                                // Payment Method
                                Container(
                                  margin: EdgeInsets.only(
                                      top: Dimensions.PADDING_SIZE_SMALL),
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  color: ColorResources.WHITE,
                                  child: Column(children: [
                                    TitleRow(title: Strings.payment_method),
                                    SizedBox(
                                        height: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    Consumer<PaymentTypeProvider>(builder:
                                        (_, paymentTypeProvider, child) {
                                      return !isAddressEmpty &&
                                              profileProvider
                                                      .paymentGatewaysList !=
                                                  null
                                          ? Row(children: [
                                              Expanded(
                                                  child: Column(
                                                      children: profileProvider
                                                          .paymentGatewaysList
                                                          .map<Widget>((e) {
                                                return buildRadio(
                                                    e, profileProvider);
                                              }).toList()))
                                            ])
                                          : const SizedBox.shrink();
                                    }),
                                  ]),
                                ),

                                // Terms
                                Container(
                                  margin: EdgeInsets.only(
                                      top: Dimensions.PADDING_SIZE_SMALL),
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  color: ColorResources.WHITE,
                                  child: Column(children: [
                                    TitleRow(title: Strings.TERMS_OF_DELIVERY),
                                    Text(Strings.lorem,
                                        style: titilliumRegular.copyWith(
                                            fontSize: Dimensions
                                                .FONT_SIZE_EXTRA_SMALL),
                                        textAlign: TextAlign.justify),
                                  ]),
                                ),
                              ]),
                        );
                      }),
                    ],
                  )
                : Center(
                    child: SpinKitFoldingCube(
                        color: ColorResources.WEB_PRIMARY_COLOR))));
  }

  Container buildAddressTopbar(BuildContext context) {
    return Container(
        height: 60,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_LARGE,
            vertical: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
            color: ColorResources.COLOR_PRIMARY,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Please add an address",
                style: titilliumSemiBold.copyWith(color: ColorResources.WHITE)),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => AddressBottomSheet());
                },
                child: Text("Add Address",
                    style: titilliumSemiBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                        color: ColorResources.PRIMARY_COLOR_BIT_DARK))),
          ],
        ));
  }

  Widget buildRadio(PaymentGateway e, ProfileProvider profileProvider) {
    print(
        "Radio button${e.id == AppConstants.COD && profileProvider.countrySelectedCode != "PK"}");
    if (e.id == AppConstants.PAY_PAL)
      return const SizedBox.shrink();
    else if (e.id == AppConstants.BACS)
      return const SizedBox.shrink();
    else if (e.id == AppConstants.COD &&
        profileProvider.countrySelectedCode == AppConstants.PK)
      return const SizedBox.shrink();
    else
      return paymentRadioBtn(profileProvider, e);
    //if (e.id != AppConstants.COD && e.id != AppConstants.PK)

    /*else
      switch (e.id) {
        case AppConstants.COD:
          return paymentRadioBtn(profileProvider, e);
          break;
      }*/
  }

  Material paymentRadioBtn(ProfileProvider profileProvider, PaymentGateway e) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          profileProvider.paymentGatewayTitle = e.title;
          profileProvider.paymentGatewaySelectedValue = e.id;
        },
        child: Row(children: [
          Radio(
            value: e.id,
            groupValue: profileProvider.paymentGatewaySelectedValue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Text("${e.title}"),
        ]),
      ),
    );
  }

  void _callback(bool isSuccess, String message, List<CartModel> carts) {
    if (isSuccess) {
      Provider.of<CartProvider>(context, listen: false)
          .removeCheckoutProduct(carts);
      Navigator.pushAndRemoveUntil(
          _scaffoldKey.currentContext,
          MaterialPageRoute(builder: (_) => DashBoardScreen()),
          (route) => false);
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message), backgroundColor: ColorResources.RED));
    }
  }
}

class PaymentButton extends StatelessWidget {
  final String image;
  final Function onTap;
  PaymentButton({@required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: ColorResources.GREY),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(image),
      ),
    );
  }
}
