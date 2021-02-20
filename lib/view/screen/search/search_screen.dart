import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/search_provider.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_scroll_loader.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final list = context.watch<SearchProvider>().searchProductList;
    list.forEach((element) { precacheImage(NetworkImage(element.thumbnail_img.first), context);});

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
              return CustomLoader( isLoading: searchProvider.isLoadingProducts, elseWidget: searchProvider.searchProductList != null
              ? searchProvider.searchProductList.isEmpty ?
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline),
                        const SizedBox(width: 10),
                        Text(AppConstants.NO_PRODUCTS_FOUND, style: titilliumSemiBold),
                      ],
                    ),
                  )
                  :
                            Expanded(
                                  child: SearchProductWidget(
                                      scrollController: _scrollController,
                                      products:
                                          searchProvider.searchProductList,
                                      isViewScrollable: true))
                  :  Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error),
                    const SizedBox(width: 10),
                    Text("Something went wrong", style: titilliumSemiBold),
                  ],
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}
