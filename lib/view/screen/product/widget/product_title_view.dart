import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';

class ProductTitleView extends StatelessWidget {
  final Product productModel;
  final WordPressProductModel wordPressProductModel;
  ProductTitleView({@required this.productModel, this.wordPressProductModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Consumer<ProductDetailsProvider>(
        builder: (context, details, child) {
          /* final stockQty = wordPressProductModel.variations.isNotEmpty
              ? wordPressProductModel.variations[0].stock_quantity != null
                  ? wordPressProductModel.variations[0].stock_quantity
                  : 0
              : 0;*/
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Flexible(
                    child: Hero(
                      tag:
                          'price-${Random().nextInt(100)}', //'price-${productModel.id}',
                      child: Row(
                        children: [
                          //: const SizedBox(width: 7),
                          Text(
                              wordPressProductModel.prefix != null &&
                                      wordPressProductModel
                                          .variations.isNotEmpty
                                  ? "${wordPressProductModel.prefix} ${wordPressProductModel.variations.first.price}"
                                  : "",
                              style: titilliumSemiBold),
                          wordPressProductModel.prefix != null &&
                                  wordPressProductModel.variations.isNotEmpty
                              ? wordPressProductModel.variations.first.on_sale
                                  ? Text(
                                      " ${wordPressProductModel.prefix} ${wordPressProductModel.variations.first.regular_price}",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.black87),
                                    )
                                  : SizedBox()
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  /*SizedBox(width: 20),
                  Hero(
                    tag:
                        'cutted-price-${Random().nextInt(100)}', //'cutted-price-${productModel.id}',
                    child: Text(
                      "",
                      */ /*PriceConverter.convertPrice(context, double.parse(productModel.unitPrice)),*/ /*
                      style: titilliumRegular.copyWith(
                          color: ColorResources.HINT_TEXT_COLOR,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),*/
                  SizedBox(width: 10),
                  /*Container(
                    width: 50,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: ColorResources.COLOR_PRIMARY),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Hero(
                        tag:
                            'off-${Random().nextInt(100)}', // 'off-${productModel.id}',
                        child: Text(
                          "Test",
                          //"${PriceConverter.percentOff(wordPressProductModel.variations.first.regular_price, wordPressProductModel.variations.first.sale_price)}% OFF",
                          style: titilliumRegular.copyWith(
                              color: ColorResources.HINT_TEXT_COLOR,
                              fontSize: 8),
                        )),
                  ),*/
                  //Expanded(child: SizedBox.shrink()),
                  /*InkWell(
                    onTap: () {
                      if (Provider.of<ProductDetailsProvider>(context,
                                  listen: false)
                              .sharableLink !=
                          null) {
                        Share.share(Provider.of<ProductDetailsProvider>(context,
                                listen: false)
                            .sharableLink);
                      }
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              spreadRadius: 3,
                              blurRadius: 10)
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.share,
                          color: ColorResources.COLOR_PRIMARY,
                          size: Dimensions.ICON_SIZE_SMALL),
                    ),
                  ),*/
                ]),
                const SizedBox(height: 7),
                Hero(
                  tag:
                      'name-${Random().nextInt(100)}', //'name-${productModel.id}',
                  child: Text(
                      "${wordPressProductModel.name}" /*productModel.name ?? ''*/,
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE),
                      maxLines: 2),
                ),
                Row(children: [
                  Hero(
                    tag:
                        'rating-${Random().nextInt(100)}', //'rating-${productModel.id}',
                    child: Text("",
                        /*productModel.rating.length > 0 ? productModel.rating[0].average : '0.0',*/ style:
                            titilliumSemiBold.copyWith(
                          color: ColorResources.HINT_TEXT_COLOR,
                          //fontSize: Dimensions.FONT_SIZE_LARGE,
                        )),
                  ),
                  //SizedBox(width: 5),
                  /*RatingBar(
                    rating: double.parse(wordPressProductModel
                        .average_rating), */ /*productModel.rating.length > 0 ? double.parse(productModel.rating[0].average) : 0.0*/ /*
                  ),*/
                  //Expanded(child: SizedBox.shrink()),
                  /* Text(
                      '${wordPressProductModel.reviewCount != null && wordPressProductModel.reviewCount > 0 ? wordPressProductModel.reviewCount : ''}  ',
                      style: titilliumRegular.copyWith(
                        color: ColorResources.HINT_TEXT_COLOR,
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      )),
                  Text(
                      '${wordPressProductModel.stock_quantity != null ? "${wordPressProductModel.stock_quantity} QTY |" : ''}',
                      style: titilliumRegular.copyWith(
                        color: ColorResources.HINT_TEXT_COLOR,
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      )),*/
                  /*Text('${details.wishCount} wish',
                      style: titilliumRegular.copyWith(
                        color: ColorResources.HINT_TEXT_COLOR,
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      )),*/
                ]),
              ]);
        },
      ),
    );
  }
}
