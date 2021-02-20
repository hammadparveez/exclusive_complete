import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/product_provider.dart';
import 'package:sixvalley_ui_kit/provider/wordpress_product_provider.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_scroll_loader.dart';
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
  Widget build(BuildContext context) {
    return Consumer<WordPressProductProvider>(
      builder: (_, wordPressProvider, child) => Consumer<ProductProvider>(
        builder: (context, prodProvider, child) {
          return wordPressProvider.listOfRelatedProducts != null
              ? CustomLoader(
                  isLoading: wordPressProvider.listOfRelatedProducts.isEmpty,
                  isExpanded: false,
                  elseWidget: GridView.builder(
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
                        isRelatedProducts: true,
                        wordPressProductModel:
                            wordPressProvider.listOfRelatedProducts[index],
                      );
                    },
                  ))
              : Center(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Nothing found")));
        },
      ),
    );
  }
}
