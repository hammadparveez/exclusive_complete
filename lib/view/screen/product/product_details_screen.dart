import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wp_product_model.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider.dart';
import 'package:sixvalley_ui_kit/provider/wordpress_product_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_screen.dart';
import 'package:sixvalley_ui_kit/view/basewidget/request_time_out_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/title_row.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/bottom_cart_view.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/product_image_view.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/product_specification_view.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/product_title_view.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/related_product_view.dart';

class ProductDetails extends StatefulWidget {
  final WordPressProductModel wordPressProductModel;
  final Product product;
  final WpProductModel wpProductModel;
  final productID;
  ProductDetails(
      {@required this.product,
      this.wpProductModel,
      this.wordPressProductModel,
      this.productID});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  WordPressProductModel model;
  @override
  void initState() {
    super.initState();
    model = widget.wordPressProductModel;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      final wordPressProvider = Provider.of<WordPressProductProvider>(context, listen: false);
      print("Init state of Product ${widget.productID}");
      wordPressProvider.resetProduct();
      wordPressProvider.initDetailProduct(productID: widget.productID);
      Provider.of<CartProvider>(context, listen: false).initTotalCartCount();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<ProductDetailsProvider, WordPressProductProvider,
        CartProvider>(
      builder: (context, details, wordPressProvider, cartProvider, child) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if(wordPressProvider.isNoInternet) {
            showDialog(context: context, barrierDismissible: false, child: NoInterNetDialog());
          }else if(wordPressProvider.isRequestTimedOut) {
            showDialog(context: context, barrierDismissible: false, child: RequestTimedOutDialog());
          }
        });
        return
            //wordPressProvider.wordPressProductModelByID != null
                Scaffold(
                    appBar: AppBar(
                      title: Row(children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios,
                              color: ColorResources.WHITE, size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                        Text(Strings.product_details,
                            style: robotoRegular.copyWith(
                                color: ColorResources.WHITE, fontSize: 20)),
                      ]),
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      backgroundColor: ColorResources
                          .PRIMARY_COLOR, //ColorResources.WHITE.withOpacity(0.5),
                    ),
                    bottomNavigationBar: BottomCartView(
                        //product: widget.product,
                        wordPressProductModel:
                            model),
                    body: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          wordPressProvider.wordPressProductModelByID !=
                                  null
                              ? ProductImageView(
                                  wordPressProductModel: wordPressProvider
                                      .wordPressProductModelByID)
                              : Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        enabled: true,
                        child: Container(
                          height: Get.height/3.5,
                          width:  Get.width /1.5,
                          decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorResources.WHITE),
                        )),


                          ProductTitleView(
                              productModel: widget.product,
                              wordPressProductModel: model,
                                  /*wordPressProvider.wordPressProductModelByID*/),

                          // Coupon
                          /*Container(
                  margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: ColorResources.WHITE,
                  child: CouponView(),
                ),*/

                          // Seller
                          /* product.addedBy == 'seller'
                    ? SellerView(sellerId: product.userId)
                    : SizedBox.shrink(),*/

                          // Specification
                          Container(
                            margin: EdgeInsets.only(
                                top: Dimensions.PADDING_SIZE_SMALL),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            color: ColorResources.WHITE,
                            child: ProductSpecification(
                              productSpecification:model.shortDescription,
                                  //"${wordPressProvider.wordPressProductModelByID.shortDescription}",
                            ), //productSpecification: product.details ?? ''),
                          ),

                          // Related Products
                          Container(
                            margin: EdgeInsets.only(
                                top: Dimensions.PADDING_SIZE_SMALL),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            color: ColorResources.WHITE,
                            child: Column(
                              children: [
                                TitleRow(
                                    title: Strings.related_products,
                                    isDetailsPage: true),
                                SizedBox(height: 5),
                                RelatedProductView(
                                    relatedItems: model.related_ids,
                                    //wordPressProvider.wordPressProductModelByID.related_ids,
                                    productType: "Dummy"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                /*: Scaffold(
                    body: Center(
                    child: CircularProgressIndicator(),
                  ));*/
      },
    );
  }
}
