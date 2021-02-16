import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_model.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/screen/order/order_details_screen.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  OrderWidget({this.orderModel});

  @override
  Widget build(BuildContext context) {
    int totalIPrice = 0;
    orderModel.listOfLineItems.forEach((element) {
      totalIPrice += int.parse(element.total).toInt();
    });
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetails(orderModel: orderModel)));
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: Dimensions.MARGIN_SIZE_DEFAULT,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text("${Strings.ORDER_ID}",
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_SMALL)),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Text(orderModel.id.toString(), style: titilliumSemiBold),
              ]),
              Row(children: [
                Text(Strings.order_date,
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_SMALL)),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Text("${orderModel.createdAt}", //orderModel.createdAt,
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                        color: ColorResources.HINT_TEXT_COLOR)),
              ]),
            ]),
            //Expanded(child: SizedBox.shrink()),
            //Expanded(child: SizedBox.shrink()),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      color: ColorResources.PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                        orderModel.payment_method_title.toString().isNotEmpty
                            ? '${orderModel.payment_method_title}'
                            : 'No Payment Method',
                        overflow: TextOverflow.ellipsis,
                        style: titilliumSemiBold.copyWith(
                            color: Colors.white,
                            fontSize: Get.textScaleFactor * 12)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(Strings.total_price,
                          style: titilliumRegular.copyWith(
                              fontSize: Get.textScaleFactor * 12)),
                      const SizedBox(width: 5),
                      Text("${orderModel.currency} ${orderModel.total}",
                          style: titilliumSemiBold.copyWith(
                              fontSize: Get.textScaleFactor * 13)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
