import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/search_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_screen.dart';
import 'package:sixvalley_ui_kit/view/basewidget/product_shimmer.dart';
import 'package:sixvalley_ui_kit/view/basewidget/search_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/search/widget/search_product_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";
  int pageCount = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
    });
    _scrollController.addListener(() {
      final maxExtent = _scrollController.position.maxScrollExtent;
      final offSet = _scrollController.offset;
      if (offSet == maxExtent) {
        pageCount++;
        print(
            "On Scroll Max ${pageCount} and $searchQuery and Query Is : ${Provider.of<SearchProvider>(context, listen: false).isAllProductsFetched}");
        if (!Provider.of<SearchProvider>(context, listen: false)
            .isAllProductsFetched) {
          Provider.of<SearchProvider>(context, listen: false)
              .searchProduct(searchQuery, pageCount);
          Provider.of<SearchProvider>(context, listen: false).scrollerLoading();
        } else {}
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.ICON_BG,
      body: Column(
        children: [
          // for tool bar
          SearchWidget(
            hintText: Strings.SEARCH_HINT,
            onSubmit: (String text) {
              searchQuery = text;
              pageCount = 1;
              Provider.of<SearchProvider>(context, listen: false)
                  .cleanSearchProduct();
              Provider.of<SearchProvider>(context, listen: false)
                  .loadingProducts();
              Provider.of<SearchProvider>(context, listen: false)
                  .searchProduct(searchQuery, pageCount);

              Provider.of<SearchProvider>(context, listen: false)
                  .saveSearchAddress(text);
            },
            onClearPressed: () {
              Provider.of<SearchProvider>(context, listen: false)
                  .cleanSearchProduct();
            },
          ),

          Consumer<SearchProvider>(
            builder: (context, searchProvider, child) {
              return !searchProvider.isLoadingProducts
                  ? !searchProvider.isClear
                      ? searchProvider.searchProductList != null
                          ? searchProvider.searchProductList.length > 0
                              ? Expanded(
                                  child: SearchProductWidget(
                                      scrollController: _scrollController,
                                      products:
                                          searchProvider.searchProductList,
                                      isViewScrollable: true))
                              : Expanded(
                                  child: NoInternetOrDataScreen(
                                      isNoInternet: false))
                          : Expanded(
                              child: ProductShimmer(
                                  isEnabled:
                                      Provider.of<SearchProvider>(context)
                                              .searchProductList ==
                                          null))
                      : Expanded(
                          flex: 4,
                          child: Container(
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                            child: Stack(
                              overflow: Overflow.visible,
                              children: [
                                /*   Provider.of<SearchProvider>(context, listen: false)
                                        .getSearchAddress()
                                        .length !=
                                    0*/
                                searchProvider.searchProductList.length != 0
                                    ? Consumer<SearchProvider>(
                                        builder:
                                            (context, searchProvider, child) =>
                                                StaggeredGridView.countBuilder(
                                          crossAxisCount: 1,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: searchProvider
                                              .searchProductList.length,
                                          itemBuilder: (context, index) =>
                                              Container(
                                                  alignment: Alignment.center,
                                                  child: InkWell(
                                                    onTap: () {
                                                      /*  Provider.of<SearchProvider>(
                                                          context,
                                                          listen: false)
                                                      .searchProduct(searchProvider
                                                              .getSearchAddress()[
                                                          index]);*/
                                                    },
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 2,
                                                          bottom: 2),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          color: ColorResources
                                                              .GREY),
                                                      width: double.infinity,
                                                      child: Center(
                                                        child: Text(
                                                          "My Search "
                                                          /*Provider.of<SearchProvider>(
                                                                      context,
                                                                      listen: false)
                                                                  .getSearchAddress()[
                                                              index] ??*/
                                                          "",
                                                          style: titilliumItalic
                                                              .copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .FONT_SIZE_SMALL),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                          staggeredTileBuilder: (int index) =>
                                              new StaggeredTile.fit(1),
                                          mainAxisSpacing: 4.0,
                                          crossAxisSpacing: 4.0,
                                        ),
                                      )
                                    : SizedBox(),
                                Positioned(
                                  top: -5,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(Strings.SEARCH_HISTORY,
                                          style: robotoBold),
                                      InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {
                                            Provider.of<SearchProvider>(context,
                                                    listen: false)
                                                .clearSearchAddress();
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                Strings.REMOVE,
                                                style:
                                                    titilliumRegular.copyWith(
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_SMALL,
                                                        color: ColorResources
                                                            .COLUMBIA_BLUE),
                                              )))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                  : Expanded(child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    );
  }
}
