import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/product_provider.dart';
import 'package:sixvalley_ui_kit/provider/wordpress_product_provider.dart';
import 'package:sixvalley_ui_kit/view/basewidget/product_widget.dart';

class RelatedProductView extends StatefulWidget {
  final String productType;
  final List relatedItems;

  const RelatedProductView(
      {Key key, this.productType, this.relatedItems = const []})
      : super(key: key);

  @override
  _RelatedProductViewState createState() => _RelatedProductViewState();
}

class _RelatedProductViewState extends State<RelatedProductView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /*Provider.of<ProductProvider>(context, listen: false)
          .initLatestProductList();*/
      Provider.of<WordPressProductProvider>(context, listen: false)
          .resetRelatedProducts();
      Provider.of<WordPressProductProvider>(context, listen: false)
          .initRelatedProduct(listRelatedItems: widget.relatedItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WordPressProductProvider>(
      builder: (_, wordPressProvider, child) => Consumer<ProductProvider>(
        builder: (context, prodProvider, child) {
          /*return Container(
            child: Center(
              child: Text("${wordPressProvider.listOfRelatedProducts.length}"),
            ),
          );*/
          return Column(children: [
            /*prodProvider.relatedProductList != null ? prodProvider.relatedProductList.length != 0 ? */

            wordPressProvider.listOfRelatedProducts != null
                ? wordPressProvider.listOfRelatedProducts.length != 0
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (1 / 1.5),
                        ),
                        itemCount: wordPressProvider.listOfRelatedProducts
                            .length, //prodProvider.relatedProductList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ProductWidget(
                            wordPressProductModel:
                                wordPressProvider.listOfRelatedProducts[index],
                            /* productModel:
                                  prodProvider.relatedProductList[index]*/
                          );
                        },
                      )
                    : Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: CircularProgressIndicator()))
                : Center(
                    child: Padding(
                        child:
                            CircularProgressIndicator())) /*ProductShimmer(
                    isEnabled: Provider.of<ProductProvider>(context)
                            .relatedProductList ==
                        null),*/
          ]);
        },
      ),
    );
  }
}
