import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/basewidget/cust_toast.dart';
import 'package:sixvalley_ui_kit/view/screen/product/product_image_screen.dart';

class ProductImageView extends StatelessWidget {
  final WordPressProductModel productModel;
  final WordPressProductModel wordPressProductModel;
  ProductImageView({@required this.productModel, this.wordPressProductModel});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    int _index = 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(

          onTap: () {
            if (wordPressProductModel != null) {
              Get.to(
                 ProductImageScreen(
                    imgModel: wordPressProductModel.images[_index])
              );
            } else {
              customToastDialog(context: context, title: "Please wait.. Original Image Loading...");
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300], spreadRadius: 3, blurRadius: 10)
              ],
          /* image: DecorationImage(image: NetworkImage(wordPressProductModel.images[_index].src)),*/
           /*   gradient: LinearGradient(
                colors: [ColorResources.PRIMARY_COLOR_BIT_DARK, ColorResources.PRIMARY_COLOR_BIT_DARK],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),*/
            ),
            child: Stack(children: [
              if(wordPressProductModel != null && wordPressProductModel.images != null)
                Image.network(wordPressProductModel.images[_index].src, height: Get.width-100, width: Get.width, fit: BoxFit.cover)
              else
                const SizedBox(),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width - 100,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount:  wordPressProductModel != null
                        ? wordPressProductModel.images.length
                        : 1,
                    itemBuilder: (context, index) {
                      _index = index;
                      if(wordPressProductModel != null) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
                          child: Hero(
                            tag: "image-view", //'image-${productModel.id}',
                            child: LayoutBuilder(
                              builder: (_, constraints) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: CachedNetworkImage(
                                      height: Get.height,
                                      width: Get.width,
                                      fadeOutDuration: Duration.zero,
                                      fadeInDuration: Duration.zero,
                                      placeholderFadeInDuration: Duration.zero,
                                      placeholder: (_, str) {
                                        return Shimmer.fromColors(
                                            baseColor: Colors.grey[300].withOpacity(.3),
                                            highlightColor: Colors.grey[100].withOpacity(.3),
                                            enabled: true,
                                            child: Container(
                                              height: constraints.maxHeight,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(10),
                                                  color: ColorResources.WHITE.withOpacity(.2)),
                                            ));
                                      },

                                      errorWidget: (_, str, value) {
                                        return Image.asset(
                                            Images.no_image_available,
                                            fit: BoxFit.fill);
                                      },
                                      imageUrl:
                                      wordPressProductModel != null
                                          ? wordPressProductModel.images[index]
                                          .shop_catalog
                                          : productModel.thumbnail_img,

                                      //"${wordPressProductModel.images != null ? wordPressProductModel.images[index].thumbnail : 'https://www.exclusiveinn.com/wp-content/uploads/2018/04/SACL09-1-600x853.jpg'}}", //productModel.images[index],
                                    ),
                                  ),
                            ),
                          ),
                        );
                      }else {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            enabled: true,
                            child: Container(
                              height: Get.width-50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius
                                      .circular(10),
                                  color: ColorResources.WHITE),
                            ));
                      }
                    },
                    onPageChanged: (index) {
                      Provider.of<ProductDetailsProvider>(context, listen: false)
                          .setImageSliderSelectedIndex(index);
                    },
                  ),
                ),
              ),
              wordPressProductModel != null
                  ? wordPressProductModel.images.length > 0
                      ? Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _indicators(context),
                            ),
                          ),
                        )
                      : const SizedBox.shrink()
                  : const SizedBox.shrink(),
            ]),
          ),
        ),

        // Image List
        wordPressProductModel != null
            ? Container(
                height: 60,
                margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: wordPressProductModel.images.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onDoubleTap: () {
                        _controller.animateToPage(index,
                            duration: Duration(microseconds: 300),
                            curve: Curves.easeInOut);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return ProductImageScreen(
                              imgModel: wordPressProductModel.images[_index]);
                        }));
                      },
                      onTap: () {
                        _controller.animateToPage(index,
                            duration: Duration(microseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      child: Container(
                        width: 60,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ColorResources.WHITE,
                          border: Provider.of<ProductDetailsProvider>(context)
                                      .imageSliderIndex ==
                                  index
                              ? Border.all(
                                  color: ColorResources.COLOR_PRIMARY, width: 2)
                              : null,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: CachedNetworkImage(
                            errorWidget: (_, str, value) {
                              return Image.asset(
                                "assets/product_images/not-available.jpg",
                                fit: BoxFit.fill,
                              );
                            },
                            imageUrl:
                                "${wordPressProductModel != null ? wordPressProductModel.images[index].woocommerce_gallery_thumbnail : 'https://www.exclusiveinn.com/wp-content/uploads/2018/04/SACL09-1-600x853.jpg'}}", //productModel.images[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  width: Get.width / 1.5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorResources.PRIMARY_COLOR_BIT_DARK),
                  child: Text("Loading Images...",
                      style: titilliumSemiBold.copyWith(
                          color: ColorResources.WHITE)),
                ),
              ),
      ],
    );
  }

  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < wordPressProductModel.images.length; index++) {
      // productModel.images.length; index++) {
      indicators.add(TabPageSelectorIndicator(
        backgroundColor: index ==
                Provider.of<ProductDetailsProvider>(context).imageSliderIndex
            ? ColorResources.COLOR_PRIMARY
            : ColorResources.WHITE,
        borderColor: ColorResources.WHITE,
        size: 10,
      ));
    }
    return indicators;
  }
}
