import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_details.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_model.dart';
import 'package:sixvalley_ui_kit/provider/order_provider.dart';
import 'package:sixvalley_ui_kit/provider/seller_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/amount_widget.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/title_row.dart';
import 'package:sixvalley_ui_kit/view/screen/order/widget/order_details_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/seller/seller_screen.dart';

class OrderDetails extends StatelessWidget {
  final OrderModel orderModel;

  const OrderDetails({Key key, this.orderModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SellerProvider>(context, listen: false)
          .removePrevOrderSeller();
      Provider.of<OrderProvider>(context, listen: false).getOrderDetails();
    });

    int totalIPrice = 0;
    orderModel.listOfLineItems.forEach((element) {
      totalIPrice += int.parse(element.total).toInt();
    });
    return Scaffold(
      backgroundColor: ColorResources.ICON_BG,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(title: Strings.ORDER_DETAILS),
          Expanded(
            child: Consumer<OrderProvider>(
              builder: (context, orderDetails, child) {
                List<String> sellerList = [];
                List<List<OrderDetailsModel>> sellerProductList = [];
                if (orderDetails.orderDetails != null) {
                  orderDetails.orderDetails.forEach((orderDetails) {
                    if (!sellerList
                        .contains(orderDetails.productDetails.userId)) {
                      sellerList.add(orderDetails.productDetails.userId);
                    }
                  });
                  sellerList.forEach((seller) {
                    if (seller != '1') {
                      Provider.of<SellerProvider>(context, listen: false)
                          .initSeller(seller);
                    }
                    List<OrderDetailsModel> orderList = [];
                    orderDetails.orderDetails.forEach((orderDetails) {
                      if (seller == orderDetails.productDetails.userId) {
                        orderList.add(orderDetails);
                      }
                    });
                    sellerProductList.add(orderList);
                  });
                }
                if (orderDetails.orderDetails != null) {
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                            horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: Strings.ORDER_ID,
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL)),
                              TextSpan(
                                  text: "${orderModel.id}",
                                  style: titilliumSemiBold.copyWith(
                                      color: ColorResources.COLOR_PRIMARY)),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_SMALL),
                        decoration: BoxDecoration(color: ColorResources.WHITE),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Strings.SHIPPING_TO,
                                    style: titilliumRegular),
                                //Expanded(child: SizedBox.shrink()),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${orderModel.billing.address_1} ${orderModel.billing.city} ${orderModel.billing.country} ${orderModel.billing.postcode}",
                                      /*orderDetails
                                            .orderDetails[0].shippingMethodId,*/
                                      overflow: TextOverflow.ellipsis,
                                      style: titilliumRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            /*   Row(children: [
                                  Expanded(
                                      child: Text(Strings.SHIPPING_PARTNER,
                                          style: titilliumRegular)),
                                  Text(Strings.SPLASH_COURIER_LTD,
                                      style: titilliumSemiBold.copyWith(
                                          color: ColorResources.COLOR_PRIMARY)),
                                ]),*/
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                      ListView.builder(
                        itemCount: sellerList.length,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL,
                                vertical: Dimensions.MARGIN_SIZE_SMALL),
                            color: ColorResources.WHITE,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (Provider.of<SellerProvider>(context,
                                                      listen: false)
                                                  .orderSellerList
                                                  .length !=
                                              0 &&
                                          sellerList[index] != '1') {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return SellerScreen(
                                              seller:
                                                  Provider.of<SellerProvider>(
                                                          context,
                                                          listen: false)
                                                      .orderSellerList[index]);
                                        }));
                                      }
                                    },
                                    child: Row(children: [
                                      Expanded(
                                          child: Text(Strings.seller,
                                              style: robotoBold)),
                                      Text(
                                        sellerList[index] == '1'
                                            ? 'Exclusive Inn'
                                            : Provider.of<SellerProvider>(
                                                            context)
                                                        .orderSellerList
                                                        .length ==
                                                    0
                                                ? sellerList[index]
                                                : '${Provider.of<SellerProvider>(context).orderSellerList[index].fName} ${Provider.of<SellerProvider>(context).orderSellerList[index].lName}',
                                        style: titilliumRegular.copyWith(
                                            color:
                                                ColorResources.HINT_TEXT_COLOR),
                                      ),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Icon(Icons.chat,
                                          color: ColorResources
                                              .PRIMARY_COLOR_BIT_DARK,
                                          size: 20),
                                    ]),
                                  ),
                                  Text(Strings.ORDERED_PRODUCT,
                                      style: robotoBold.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color:
                                              ColorResources.HINT_TEXT_COLOR)),
                                  Divider(),
                                  OrderDetailsWidget(orderModel: orderModel),
                                  /*ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.all(0),
                                        itemCount:
                                            orderDetails.orderDetails.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) =>

                                      ),*/
                                ]),
                          );
                        },
                      ),
                      SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                      // Amounts
                      Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        color: ColorResources.WHITE,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleRow(title: Strings.TOTAL),
                              AmountWidget(
                                  title: "Order Status",
                                  amount: orderModel.orderStatus.toUpperCase()),
                              AmountWidget(
                                  title: Strings.SHIPPING_FEE,
                                  amount:
                                      "${orderModel.shipping.first.method_title} ${orderModel.shipping.first.total != 0.toString() ? orderModel.shipping.first.total : ""}"),
                              //" ${orderModel.currency} ${orderModel.shipping_total}"),
                              /*AmountWidget(
                                      title: Strings.DISCOUNT,
                                      amount:
                                          "${orderModel.currency} ${orderModel.discountAmount}"),
                                  AmountWidget(
                                      title: Strings.TAX,
                                      amount:
                                          "${orderModel.currency} ${orderModel.discountAmount}"),*/
                              AmountWidget(
                                  title: "Amount",
                                  amount:
                                      "${orderModel.currency} $totalIPrice"),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Divider(
                                    height: 2,
                                    color: ColorResources.HINT_TEXT_COLOR),
                              ),
                              AmountWidget(
                                  title: Strings.TOTAL_PAYABLE,
                                  amount:
                                      "${orderModel.currency} ${orderModel.total}"),
                            ]),
                      ),
                      SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: Dimensions.MARGIN_SIZE_SMALL,
                          right: Dimensions.MARGIN_SIZE_SMALL,
                          top: Dimensions.MARGIN_SIZE_SMALL,
                          bottom: Dimensions.MARGIN_SIZE_SMALL,
                        ),
                        decoration: BoxDecoration(color: ColorResources.WHITE),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Strings.PAYMENT, style: robotoBold),
                            SizedBox(
                                height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Strings.PAYMENT_STATUS,
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                Text(
                                  "${orderModel.payment_method_title}", //Strings.PAID,
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Strings.PAYMENT_PLATFORM,
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                Text(
                                  "${orderModel.paymentMethod.toUpperCase()}", //Strings.VISA,
                                  style: titilliumBold.copyWith(
                                      color: ColorResources.COLOR_PRIMARY),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                          right: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                          top: Dimensions.MARGIN_SIZE_SMALL,
                          bottom: Dimensions.MARGIN_SIZE_SMALL,
                        ),
                        child: Row(
                          children: [
                            /*Expanded(
                                  child: Container(
                                    height: 45,
                                    child: CustomButton(
                                      buttonText: Strings.TRACK_ORDER,
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TrackingScreen()));
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.MARGIN_SIZE_SMALL), */
                            /*     Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: 45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                ColorResources.COLOR_PRIMARY),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: FlatButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  SupportTicketScreen())),
                                      child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: Text(Strings.SUPPORT_CENTER,
                                              style: titilliumSemiBold.copyWith(
                                                  fontSize: 16,
                                                  color: ColorResources
                                                      .COLOR_PRIMARY))),
                                    ),
                                  ),
                                ),*/
                          ],
                        ),
                      ),
                      //SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: Dimensions.MARGIN_SIZE_SMALL,
                          right: Dimensions.MARGIN_SIZE_SMALL,
                          top: Dimensions.MARGIN_SIZE_SMALL / 2,
                          bottom: Dimensions.MARGIN_SIZE_SMALL,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Strings.TERMS_OF_DELIVERY, style: robotoBold),
                            SizedBox(
                                height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                            Text(Strings.LOREM__ELITR,
                                style: titilliumRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_SMALL))
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
