import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/helper/product_type.dart';
import 'package:sixvalley_ui_kit/provider/wordpress_product_provider.dart';
import 'package:sixvalley_ui_kit/view/basewidget/product_shimmer.dart';
import 'package:sixvalley_ui_kit/view/basewidget/product_widget.dart';
import 'package:sixvalley_ui_kit/view/basewidget/request_time_out_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_dialog.dart';
class ProductView extends StatefulWidget {
  final ProductType productType;
  final ScrollController scrollController;
  final String sellerId;
  ProductView(
      {@required this.productType, this.scrollController, this.sellerId});

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<WordPressProductProvider>(
      builder: (ctx, wpProvider, child) =>
      wpProvider.isNoInternet ?
      NoInterNetDialog()
          :
      wpProvider.isRequestTimedOut ?
      RequestTimedOutDialog()
          :
      !wpProvider.firstLoading
          ? wpProvider.listOfFeaturedProducts.isNotEmpty
              ? GridView.builder(
                  padding: EdgeInsets.all(0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (1 / 1.5),
                  ),
                  itemCount: wpProvider.listOfFeaturedProducts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ProductWidget(
                      wordPressProductModel:
                          wpProvider.listOfFeaturedProducts[index],
                    );
                  },
                ):
              Center(child: Text("No Products Found"))
          : ProductShimmer(
              isEnabled: wpProvider.firstLoading),
    );
  }
}
