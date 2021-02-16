import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/helper/price_converter.dart';
import 'package:sixvalley_ui_kit/provider/wishlist_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/cart_bottom_sheet.dart';

class WishListWidget extends StatelessWidget {
  final WordPressProductModel wordPressProductModel;
  final Product product;
  final int index;
  WishListWidget({this.product, this.index, this.wordPressProductModel});

  @override
  Widget build(BuildContext context) {
    feedbackMessage(String message) {
      if (message != '') {
        showCustomSnackBar(message, context);
      }
    }

    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      margin: EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
      decoration: BoxDecoration(
          color: ColorResources.WHITE, borderRadius: BorderRadius.circular(5)),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            Image.network(
              "wordPressProductModel.thumbnail",
              //product.thumbnail,
              fit: BoxFit.scaleDown,
              width: 45,
              height: 45,
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          " wordPressProductModel.title", //product.name,
                          style: titilliumRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                            color: ColorResources.colorMap[900],
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: ColorResources.HINT_TEXT_COLOR,
                        radius: 10,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.center,
                          icon: Icon(Icons.edit,
                              color: ColorResources.WHITE, size: 10),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => new CupertinoAlertDialog(
                                      title: new Text(Strings
                                          .ARE_YOU_SURE_WANT_TO_REMOVE_WISH_LIST),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(Strings.YES),
                                          onPressed: () {
                                            //print(product.id);

                                            Provider.of<WishListProvider>(
                                                    context,
                                                    listen: false)
                                                .removeWishList(product,
                                                    index: index,
                                                    feedbackMessage:
                                                        feedbackMessage,
                                                    wordPressProductModel:
                                                        wordPressProductModel);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text(Strings.NO),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ));
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          PriceConverter.convertPrice(
                            context,
                            0,
                          ), //double.parse(product.unitPrice)),
                          style: titilliumSemiBold.copyWith(
                              color: ColorResources.COLOR_PRIMARY),
                        ),
                      ),
                      Text(
                        'QTY ${wordPressProductModel ?? 0}', //'x${product.minQty}',
                        style: titilliumSemiBold.copyWith(
                            color: ColorResources.colorMap[500]),
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.only(
                            left: Dimensions.PADDING_SIZE_SMALL),
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: ColorResources.COLOR_PRIMARY)),
                        child: Text(
                          '${/*double.parse(product.discount.toString())*/ 0}% OFF',
                          style: titilliumRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              color: ColorResources.colorMap[500]),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (con) => CartBottomSheet(
                                  product: product,
                                  wordPressProductModel: wordPressProductModel,
                                  isBuy: true,
                                  callback: () {}));
                        },
                        child: Container(
                          height: 20,
                          margin: EdgeInsets.only(
                              left: Dimensions.PADDING_SIZE_SMALL),
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                              gradient: LinearGradient(colors: [
                                ColorResources.COLOR_PRIMARY,
                                ColorResources.COLOR_PRIMARY,
                                ColorResources.COLOR_PRIMARY,
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart,
                                  color: ColorResources.WHITE, size: 10),
                              FittedBox(
                                child: Text(Strings.buy_now,
                                    style: titilliumBold.copyWith(
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_SMALL,
                                        color: ColorResources.WHITE)),
                              ),
                            ],
                          ),
                        ),
                      ),
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
