import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
import 'package:sixvalley_ui_kit/provider/product_provider.dart';
import 'package:sixvalley_ui_kit/provider/wordpress_product_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_scroll_loader.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_screen.dart';
import 'package:sixvalley_ui_kit/view/basewidget/product_shimmer.dart';
import 'package:sixvalley_ui_kit/view/basewidget/product_widget.dart';

class BrandAndCategoryProductScreen extends StatefulWidget {
  final bool isBrand;
  final String id;
  final String name;
  final String image;
  final Category category;
  BrandAndCategoryProductScreen({
    this.isBrand,
    this.id,
    this.name,
    this.category,
    this.image,
  });

  @override
  _BrandAndCategoryProductScreenState createState() =>
      _BrandAndCategoryProductScreenState();
}

class _BrandAndCategoryProductScreenState
    extends State<BrandAndCategoryProductScreen> {
  ScrollController _scrollController = ScrollController();
  int counter = 10, pageCount = 1;
  int totalItemsCount = 0;
  bool isLoaderShown = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final wpProvider =
          Provider.of<WordPressProductProvider>(context, listen: false);
      wpProvider.resetCategoryList();
      wpProvider.initTotalCategoryCounts(widget.category.slug).then((value) {
        wpProvider.initBrandAndCategoryProducts(
            slug: widget.category.slug, pageCount: pageCount);
        totalItemsCount = wpProvider.categoryTotalCount;
        print("Total products in category $totalItemsCount");
      });
    });
    //Scroll Controller Listner
    _scrollController.addListener(() {
      final maxExtent = _scrollController.position.maxScrollExtent;
      final offSet = _scrollController.offset;
      final initOffset = _scrollController.initialScrollOffset;
      if (offSet == maxExtent) {
        print(
            "${offSet}  and $maxExtent Do they are same $totalItemsCount and Counter is ${counter}");
        if (counter <= totalItemsCount) {
          counter += 10;
          pageCount++;
          print("Pagecount $pageCount and Counter $counter");
          Provider.of<WordPressProductProvider>(context, listen: false)
              .isLoadingMore = true;
          Provider.of<WordPressProductProvider>(context, listen: false)
              .initBrandAndCategoryProducts(
                  slug: widget.category.slug, pageCount: pageCount);
        }
      } else if (offSet > (maxExtent + 40)) {
      } else {}
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final categoryProducts =
        context.watch<WordPressProductProvider>().listOfCategoryProducts;
    categoryProducts.forEach((feature) {
      precacheImage(NetworkImage(feature.thumbnail_img.first), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.ICON_BG,
      body: Consumer<WordPressProductProvider>(
        builder: (_, wordPressProvider, child) => Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            print(
                "Total ITems in Category ${wordPressProvider.categoryTotalCount} and ${pageCount} and Countrt ${counter} and ${wordPressProvider.listOfCategoryProducts.length} Category Products");
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomAppBar(title: widget.category.categoryName),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_LARGE,
                        vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              "Category ${widget.category.categoryName}",
                              style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                  color: Colors.black45)),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Brand Details
                  widget.isBrand
                      ? Container(
                          height: 100,
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                          margin: EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_SMALL),
                          color: ColorResources.WHITE,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /*Image.network(
                                  "https://image.freepik.com/free-vector/shining-circle-purple-lighting-isolated-dark-background_1441-2396.jpg",
                                  width: 80,
                                  height: 80,
                                ),*/
                                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                Text(widget.category.name,
                                    style: titilliumSemiBold.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_LARGE)),
                              ]),
                        )
                      : SizedBox.shrink(),

                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  // Products
                  //productProvider.brandOrCategoryProductList.length > 0
                  wordPressProvider.listOfCategoryProducts.length > 0 //&&
                      /*  (wordPressProvider.listOfCategoryProducts.length <
                              wordPressProvider.categoryTotalCount)*/
                      ? Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL),
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (1 / 1.5),
                            ),
                            itemCount:
                                wordPressProvider.listOfCategoryProducts.length,
                            //wordPressProvider.listOfCategoryProducts.length,
                            /*productProvider
                                .brandOrCategoryProductList.length,*/
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemBuilder: (BuildContext context, int index) {
                              /* print(
                                  "Hello ${productProvider.brandOrCategoryProductList[index]}");*/
                              /*Container(
                                  child: Image.network(
                                      "${productProvider.brandOrCategoryProductList[index].images[0]["thumbnail"]}"));*/
                              return ProductWidget(
                                wordPressProductModel: wordPressProvider
                                    .listOfCategoryProducts[index],
                                /* wpProductModel: productProvider
                                      .brandOrCategoryProductList[index]*/
                              );
                              /*ProductWidget(
                                wpProductModel: productProvider
                                    .brandOrCategoryProductList[index],
                                */ /*  productModel: productProvider
                                      .brandOrCategoryProductList[index]*/ /*
                              );*/
                            },
                          ),
                        )
                      : wordPressProvider.listOfRelatedProducts.length == 0
                          ? Expanded(
                              child: Center(
                              child: wordPressProvider
                                          .listOfRelatedProducts.length ==
                                      0
                                  ? CircularProgressIndicator()
                                  : NoInternetOrDataScreen(
                                      isNoInternet:
                                          false), //productProvider.hasData
                              /*  ? ProductShimmer(
                                  isEnabled:
                                      Provider.of<ProductProvider>(context)
                                              .brandOrCategoryProductList
                                              .length ==
                                          0) */
                            ))
                          : Expanded(
                              child: Center(
                                  child: ProductShimmer(isEnabled: true))),
                  CustomScrollLoader(isLoading: wordPressProvider.isLoadingMore)
                ]);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
