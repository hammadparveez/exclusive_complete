import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_ui_kit/provider/app_category_provider.dart';
import 'package:sixvalley_ui_kit/provider/category_provider.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/screen/product/brand_and_category_product_screen.dart';

class CategoryView extends StatelessWidget {
  final bool isHomePage;
  CategoryView({@required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    List<String> _categories = [];
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return categoryProvider.categoryList.length != 0
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: (1 / 1),
                ),
                itemCount: categoryProvider.categoryList.length,
                /* isHomePage
                          ? categoryProvider.categoryList.length > 8
                              ? 8
                              : categoryProvider.categoryList.length
                          : categoryProvider.categoryList.length,*/
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BrandAndCategoryProductScreen(
                                    image: categoryProvider
                                        .categoryList[index].icon,
                                    isBrand: false,
                                    name: categoryProvider
                                        .categoryList[index].name,
                                    id: categoryProvider.categoryList[index].id
                                        .toString(),
                                    category: categoryProvider.categoryList[
                                        index], /*categoryProvider
                                          .categoryList[index].name*/
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            Dimensions.PADDING_SIZE_SMALL),
                        color: ColorResources.WHITE,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          )
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    /*horizontal: Dimensions.PADDING_SIZE_LARGE,
                                    vertical: Dimensions.PADDING_SIZE_SMALL*/
                                    ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: LayoutBuilder(
                                    builder:(_, constraints) => CachedNetworkImage(
                                      imageUrl: categoryProvider
                                                      .categoryList[index].icon !=
                                                  null &&
                                              categoryProvider.categoryList[index]
                                                  .icon.isNotEmpty
                                          ? categoryProvider
                                              .categoryList[index].icon
                                          : AppConstants.NO_IMAGE_URI,
                                      fadeOutDuration: Duration.zero,
                                      fadeInCurve: Curves.linear,
                                      filterQuality: FilterQuality.low,
                                      fit: BoxFit.cover,
                                      placeholder: (_,s) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.black38,
                                          highlightColor: Colors.black12,
                                          child: Container(width: constraints.maxWidth, height: constraints.maxHeight,),
                                        );
                                      },
                                      errorWidget: (_, str, value) {
                                        return Image.asset(
                                            "assets/product_images/not-available.jpg",
                                            fit: BoxFit.fill);
                                      },
                                    ),
                                  ),

                                  /*Image.network(
                                      categoryProvider.categoryList[index].icon,
                                      fit: BoxFit.cover,
                                    ),*/
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 1),
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .black87, //ColorResources.TEXT_BG,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Center(
                                      child: Html(
                                    data: categoryProvider.categoryList[index]
                                        .name.allWordsCapitilize,
                                    style: {
                                      "body": Style(
                                        color: Colors.white,
                                        textAlign: TextAlign.center,
                                        fontSize:
                                            FontSize(Get.textScaleFactor * 10),
                                      ),
                                    },
                                  ) /*Text(
                                      categoryProvider.categoryList[index].name
                                          .allWordsCapitilize,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: titilliumSemiBold.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color: Colors.white),
                                    ),*/
                                      ),
                                )),
                          ]),
                    ),
                  );
                },
              )
            : CategoryShimmer();
      },
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: (1 / 1),
      ),
      itemCount: 8,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.grey[200], spreadRadius: 2, blurRadius: 5)
          ]),
          margin: EdgeInsets.all(3),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              flex: 7,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: Provider.of<CategoryProvider>(context)
                        .categoryList
                        .length ==
                    0,
                child: Container(
                    decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                )),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorResources.TEXT_BG,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    enabled: Provider.of<CategoryProvider>(context)
                            .categoryList
                            .length ==
                        0,
                    child: Container(
                        height: 10,
                        color: ColorResources.WHITE,
                        margin: EdgeInsets.only(left: 15, right: 15)),
                  ),
                )),
          ]),
        );
      },
    );
  }
}
