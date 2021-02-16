import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/provider/search_provider.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/product_widget.dart';

class SearchProductWidget extends StatefulWidget {
  final ScrollController scrollController;
  final bool isViewScrollable;
  //final List<Product> products;
  final List<WordPressProductModel> products;
  SearchProductWidget(
      {this.isViewScrollable, this.products, this.scrollController});

  @override
  _SearchProductWidgetState createState() => _SearchProductWidgetState();
}

class _SearchProductWidgetState extends State<SearchProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        children: [
          /*   Row(
            children: [
              Expanded(
                child: Text(
                  'Here are your search product(s)', //'Search result for \"${Provider.of<SearchProvider>(context).searchText}\" (${widget.products.length} items)',
                  style: titilliumRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_DEFAULT),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              */ /*InkWell(
                onTap: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (c) => SearchFilterBottomSheet()),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                    color: ColorResources.LOW_GREEN,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: ColorResources.HINT_TEXT_COLOR),
                  ),
                  child: Row(children: [
                    Image.asset(Images.filter_image, width: 10, height: 10),
                    Text('Filter'),
                  ]),
                ),
              ),*/ /*
            ],
          ),*/
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (_, searchProvider, child) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: widget.scrollController,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: (1 / 1.5)),
                      itemCount: widget.products.length,
                      //shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductWidget(
                            /*productModel*/ wordPressProductModel:
                                widget.products[index]);
                      },
                    ),
                  ),
                  searchProvider.onScrollLoader
                      ? const Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
