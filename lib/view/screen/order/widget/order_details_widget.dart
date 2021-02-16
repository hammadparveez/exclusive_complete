import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_details.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_model.dart';
import 'package:sixvalley_ui_kit/provider/order_provider.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider.dart';
import 'package:sixvalley_ui_kit/provider/wordpress_product_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';

class OrderDetailsWidget extends StatelessWidget {
  final OrderDetailsModel orderDetailsModel;
  final OrderModel orderModel;
  OrderDetailsWidget({this.orderDetailsModel, this.orderModel});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductDetailsProvider>(context, listen: false).removeError();
      Provider.of<WordPressProductProvider>(context, listen: false)
          .findProductById(orderModel.listOfLineItems.first.product_id);
    });

    return Consumer<WordPressProductProvider>(
        builder: (context, wpProvider, child) {
      /*   final salePrice = wpProvider.foundProductModel.sale_price != null
          ? wpProvider.foundProductModel.sale_price
          : 0;
      final regularPrice = wpProvider.foundProductModel.price != null
          ? wpProvider.foundProductModel.price
          : 0;*/
      return InkWell(
        onTap: () {
          if (Provider.of<OrderProvider>(context, listen: false)
                  .orderTypeIndex ==
              1) {
            /* showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => ReviewDialog(
                    productID: orderDetailsModel.productDetails.id.toString()));*/
          }
        },
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /*CachedNetworkImage(
                    imageUrl:
                        "${wpProvider.foundProductModel.}", //orderDetailsModel.productDetails.thumbnail,
                    fit: BoxFit.scaleDown,
                    width: 50,
                    height: 50,
                  ),*/
                  //SizedBox(width: Dimensions.MARGIN_SIZE_DEFAULT),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (LineItems lineItem in orderModel.listOfLineItems)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${lineItem.name}", //"${orderDetailsModel.productDetails.name}",
                                style: titilliumSemiBold.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_SMALL,
                                    color: ColorResources.HINT_TEXT_COLOR),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('Qty: x${lineItem.quantity}',
                                  style: titilliumSemiBold.copyWith(
                                      color: ColorResources.colorMap[500])),
                            ],
                          ),
                        /*SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${orderModel.currency} ${orderModel.listOfLineItems.first.total}",
                              style: titilliumSemiBold.copyWith(
                                  color: ColorResources.COLOR_PRIMARY),
                            ),
*/
                        /*Container(
                              height: 20,
                              width: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: ColorResources.COLOR_PRIMARY)),
                              child: Text(
                                "${PriceConverter.percentOff(regularPrice, '0')}% OFF",
                                //'${double.parse(orderDetailsModel.discount) ~/ (double.parse(orderDetailsModel.price) / 100)}% OFF',
                                style: titilliumRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                    color: ColorResources.colorMap[500]),
                              ),
                            ),*/
                        /*],
                        ),*/
                      ],
                    ),
                  ),
                  /*Provider.of<OrderProvider>(context).orderTypeIndex == 1
                      ? Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.PADDING_SIZE_SMALL),
                          padding: EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          decoration: BoxDecoration(
                            color: ColorResources.COLOR_PRIMARY,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 2, color: ColorResources.COLUMBIA_BLUE),
                          ),
                          child: Text(Strings.review,
                              style: titilliumRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                color: ColorResources.WHITE,
                              )),
                        )
                      : SizedBox.shrink(),*/
                ],
              ),
              Divider(),
            ],
          ),
        ),
      );
    });
  }
}
