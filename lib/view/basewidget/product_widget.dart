import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/screen/product/product_details_screen.dart';

class ProductWidget extends StatelessWidget {
  final WordPressProductModel wordPressProductModel;
  final Product productModel;
  ProductWidget({@required this.productModel, this.wordPressProductModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 1000),
                pageBuilder: (context, anim1, anim2) {
                  return ProductDetails(
                    productID: wordPressProductModel.id,
                    wordPressProductModel: wordPressProductModel,
                    product: productModel,
                  );
                }));
      },
      child: wordPressProductModel.images != null ||
              wordPressProductModel.images.isNotEmpty
          ? Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorResources.WHITE,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5)
                ],
              ),
              child: Stack(children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Product Image
                      Expanded(
                        flex: 6,
                        child: Container(
                          //padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                          decoration: BoxDecoration(
                            color: ColorResources.ICON_BG,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          child: CachedNetworkImage(
                            placeholder: (_, str) {
                              return Shimmer.fromColors(
                                child: SizedBox.expand(),
                                enabled: true,
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                              );
                            },
                            imageUrl: wordPressProductModel
                                    .thumbnail_img.isNotEmpty
                                ? "${wordPressProductModel.thumbnail_img.first}"
                                : AppConstants.NO_IMAGE_URI,
                            errorWidget: (_, str, value) {
                              return Image.asset(
                                "assets/product_images/not-available.jpg",
                                fit: BoxFit.cover,
                              );
                            },
                            fadeInCurve: Curves.bounceInOut,
                            fadeInDuration: Duration.zero,
                            fadeOutDuration: Duration.zero,

                            //"https://images.pexels.com/photos/1591447/pexels-photo-1591447.jpeg",
                            //fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Product Details
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${wordPressProductModel.name}",
                                  style: robotoRegular.copyWith(
                                      fontSize: Get.textScaleFactor * 12.5),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(
                                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              //Html(data: wordPressProductModel.price_html),
                              wordPressProductModel.prefix != null &&
                                      wordPressProductModel
                                          .variations.isNotEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${wordPressProductModel.prefix} ${wordPressProductModel.variations.first.price} ",
                                          style: titilliumBold.copyWith(
                                              color:
                                                  ColorResources.COLOR_PRIMARY,
                                              fontSize:
                                                  Get.textScaleFactor * 11),
                                        ),
                                        wordPressProductModel
                                                .variations.first.on_sale
                                            ? Text(
                                                "${wordPressProductModel.prefix} ${wordPressProductModel.variations.first.regular_price} ",
                                                style: TextStyle(
                                                    fontSize:
                                                        Get.textScaleFactor *
                                                            11,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              )
                                            : SizedBox(),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              /*Text("$sale_price",
                        style: robotoBold.copyWith(
                            color: ColorResources.PRIMARY_COLOR)),*/
                              SizedBox(
                                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Row(children: [
                                Text(
                                  "${wordPressProductModel.featured != null ? 'Products' : wordPressProductModel.count}",
                                  /*  PriceConverter.convertPrice(
                            context, double.parse(productModel.unitPrice)),*/
                                  style: robotoBold.copyWith(
                                    color: ColorResources.HINT_TEXT_COLOR,
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  ),
                                ),
                                Expanded(child: SizedBox.shrink()),
                                /*   Text(
                                    "${wordPressProductModel.average_rating}"*/
                                /* productModel.rating != null
                              ? productModel.rating.length != 0
                                  ? productModel.rating[0].average
                                  : '0.0'
                              : '0.0',*/
                                /*  ,
                                    style: robotoRegular.copyWith(
                                      color: Colors.orange,
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                    )),
                                Icon(Icons.star,
                                    color: Colors.orange, size: 15),*/
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ]),

                // Off
                wordPressProductModel != null
                    ? Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            color: ColorResources.PRIMARY_COLOR,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text(
                              "${wordPressProductModel.on_sale ? 'SALE' : 'AVAILABLE'}",
                              style: robotoRegular.copyWith(
                                  color: ColorResources.WHITE,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ]),
            )
          : const SizedBox.shrink(),
    );
  }

  getPrice() {
    final wp = wordPressProductModel;
    if (wp.price != null || wp.price.isNotEmpty) {
      return wp.price;
    }
    return 0;
  }

  getSalePrice() {
    final wp = wordPressProductModel;
    if (wp.sale_price != null || wp.sale_price.isNotEmpty) {
      return wp.sale_price;
    }
    return 0;
  }

  bool onSale() {
    final wp = wordPressProductModel;
    if (wp.on_sale != null) {
      return wp.on_sale;
    }
    return false;
  }

  getRegularPrice() {
    final wp = wordPressProductModel;
    if (wp.regular_price != null && wp.regular_price.isNotEmpty) {
      return wp.regular_price;
    }
    return 0;
  }
}
