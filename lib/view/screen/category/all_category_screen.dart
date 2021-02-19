import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
import 'package:sixvalley_ui_kit/provider/category_provider.dart';
import 'package:sixvalley_ui_kit/provider/wordpress_product_provider.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_scroll_loader.dart';
import 'package:sixvalley_ui_kit/view/basewidget/product_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/product/brand_and_category_product_screen.dart';

class AllCategoryScreen extends StatefulWidget {
  @override
  _AllCategoryScreenState createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _gridViewScrollController = ScrollController();

  int totalNoProducts = 0;
  String slug, name;
  int pageCount = 0;
  bool isLoadingProducts = false;
  @override
  void initState() {
    pageCount = 1;
    // TODO: implement initState
    super.initState();
    WordPressProductProvider wordPressProvider;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wordPressProvider =
          Provider.of<WordPressProductProvider>(context, listen: false);
      wordPressProvider.resetCategoryList();
      wordPressProvider.isLoadingProducts = true;
      wordPressProvider.initRandomProducts(Random().nextInt(10));
      //wordPressProvider.isLoadingProducts = false;
    });

    _scrollController.addListener(() async {
      await wordPressProvider.initTotalCategoryCounts(slug);
      final maxExtent = _scrollController.position.maxScrollExtent;
      final offset = _scrollController.offset;
      if (offset == maxExtent) {
        if (wordPressProvider.listOfRandomProducts.length > 0) {
          print("Random Product Length");
          wordPressProvider.isLoadingMore = true;
          wordPressProvider.initRandomProducts(Random().nextInt(10));
        } else if ((wordPressProvider.listOfCategoryProducts != null) &&
            wordPressProvider.listOfCategoryProducts.length <
                wordPressProvider.categoryTotalCount) {
          print("Proper Products Are");
          pageCount++;
          print(
              "Scroll Controller Slug: $slug and Pagecount: $pageCount and TotalCount ${wordPressProvider.categoryTotalCount}");
          wordPressProvider.isLoadingMore = true;
          wordPressProvider.initBrandAndCategoryProducts(
              pageCount: pageCount, slug: slug);
        } else {
          wordPressProvider.isLoadingMore = false;
        }
      }
    });
  }

  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  onChanged(BuildContext context, index) {
    pageCount = 1;
    final wordPressProvider =
        Provider.of<WordPressProductProvider>(context, listen: false);
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    slug = categoryProvider.selectedCategorySlug =
        categoryProvider.allCategories[index].slug;
    wordPressProvider.resetCategoryList();
    wordPressProvider.isLoadingProducts = true;
    wordPressProvider.initBrandAndCategoryProducts(
      pageCount: pageCount,
      slug: categoryProvider.selectedCategorySlug,
    );
    name = categoryProvider.categoryList[index].name;
    wordPressProvider
        .initTotalCategoryCounts(categoryProvider.selectedCategorySlug);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) => Scaffold(
        endDrawer: SafeArea(
          child: Drawer(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*buildSelectTypeContainer("Filter by price"),
                  Divider(color: Colors.black38),
                  Column(
                    children: [
                      RangeSlider(
                        labels: RangeLabels("PKR 100", "PKR 1000"),
                        activeColor: Color(0xffec7a5c),
                        values: RangeValues(1, 100),
                        onChanged: (rangeValue) {
                          print("Value is being changed $rangeValue");
                        },
                        min: 1,
                        max: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price: 0 PKR to 100 PKR",
                              style: titilliumBold.copyWith(
                                  color: Colors.black54)),
                          MaterialButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            elevation: 0,
                            focusElevation: 0,
                            highlightElevation: 0,
                            color: Colors.transparent,
                            textColor: Color(0xffec7a5c),
                            onPressed: () {},
                            child: Text("FILTER",
                                style: titilliumSemiBold.copyWith(
                                  color: Color(0xffec7a5c),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),*/
                  /*            buildSelectTypeContainer("Filter by Size"),
                  Divider(color: Colors.black38),
                  Column(
                    children: [
                      CheckboxListTile(
                        value: true,
                        onChanged: (value) {},
                        title: Text("Extra Small"),
                      ),
                      CheckboxListTile(
                        value: true,
                        onChanged: (value) {},
                        title: Text("Small"),
                      ),
                      CheckboxListTile(
                        value: true,
                        onChanged: (value) {},
                        title: Text("Large"),
                      ),
                    ],
                  ),*/
                  buildSelectTypeContainer("Select a Category"),
                  Divider(color: Colors.black38),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: categoryProvider.allCategories.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.all(0),
                            visualDensity: VisualDensity.compact,
                            onTap: () {
                              onChanged(context, index);
                            },
                            leading: Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              //visualDensity: VisualDensity.compact,
                              activeColor:
                                  ColorResources.PRIMARY_COLOR_BIT_DARK,
                              groupValue: categoryProvider.selectedCategorySlug,
                              onChanged: (value) {
                                categoryProvider.selectedCategorySlug = value;
                                onChanged(context, index);
                              },
                              value: categoryProvider.allCategories[index].slug,
                            ),
                            title: Text(
                                "${categoryProvider.allCategories[index].name}"),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: ColorResources.ICON_BG,
        body: Column(
          children: [
            CustomAppBar(title: Strings.CATEGORY ?? ""),
            Expanded(child: Consumer<WordPressProductProvider>(
              builder: (context, wordPressProvider, child) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.notes),
                                    onPressed: () {
                                      Scaffold.of(context).openEndDrawer();
                                    },
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  //Icon(Icons.notes),
                                  const SizedBox(width: 5),
                                  Text("All Categories",
                                      style: titilliumSemiBold),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.filter_alt_outlined),
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: LayoutBuilder(builder: (_, constraints) {
                        return CustomLoader(isLoading: wordPressProvider.isLoadingProducts,
                            elseWidget:  wordPressProvider.listOfRandomProducts.isNotEmpty ||
                                    wordPressProvider
                                            .listOfCategoryProducts.isNotEmpty
                                  ? SingleChildScrollView(
                                    controller: _scrollController,
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        GridView.builder(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          controller: _gridViewScrollController,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: (1 / 1.5),
                                          ),
                                          scrollDirection: Axis.vertical,
                                          itemCount: wordPressProvider
                                                  .listOfRandomProducts
                                                  .isNotEmpty
                                              ? wordPressProvider
                                                  .listOfRandomProducts.length
                                              : wordPressProvider
                                                  .listOfCategoryProducts
                                                  .length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ProductWidget(
                                              wordPressProductModel: wordPressProvider
                                                          .listOfRandomProducts
                                                          .length >
                                                      0
                                                  ? wordPressProvider
                                                          .listOfRandomProducts[
                                                      index]
                                                  : wordPressProvider
                                                          .listOfCategoryProducts[
                                                      index],
                                            );

                                            //: Container(); //productModel: productList[index]);
                                          },
                                        ),
                                        CustomScrollLoader(isLoading: wordPressProvider.isLoadingMore),

                                      ],
                                    ),
                                  )
                                : SingleChildScrollView(
                                    controller: _scrollController,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.info_outline,
                                            color: Colors.black87,
                                            size: Dimensions.ICON_SIZE_LARGE),
                                        const SizedBox(width: 7),
                                        Text(
                                            " ${AppConstants.NO_PRODUCTS_FOUND}",
                                            style: titilliumSemiBold),
                                      ],
                                    ),
                        ) );
                            /*: Padding(
                                padding: EdgeInsets.all(8),
                                child:
                                    Center(child: CircularProgressIndicator()))*/;
                      }),
                    )
                  ],
                );
                return categoryProvider.categoryList.length != 0
                    ? Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          margin: EdgeInsets.only(top: 3),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  spreadRadius: 3,
                                  blurRadius: 10)
                            ],
                          ),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: categoryProvider.categoryList.length,
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              Category _category =
                                  categoryProvider.categoryList[index];
                              return InkWell(
                                onTap: () {
                                  Provider.of<CategoryProvider>(context,
                                          listen: false)
                                      .changeSelectedIndex(index);
                                },
                                child: CategoryItem(
                                  title: _category.name,
                                  icon: _category.icon,
                                  isSelected:
                                      categoryProvider.categorySelectedIndex ==
                                          index,
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            itemCount: categoryProvider.categoryList.length,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: (1 / 1),
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              return const SizedBox.shrink();
                              return Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorResources.PRIMARY_COLOR
                                            .withOpacity(.5),
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                        spreadRadius: 3),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: categoryProvider
                                          .categoryList[index].icon,
                                      fit: BoxFit.cover,
                                    ),
                                    Html(
                                        data:
                                            "${categoryProvider.categoryList[index].name}"),
                                  ],
                                ),
                              );
                              /*SubCategory _subCategory;
                            if (index != 0) {
                              _subCategory = categoryProvider
                                  .categoryList[
                                      categoryProvider.categorySelectedIndex]
                                  .subCategories[index - 1];
                            }
                            if (index == 0) {
                              return Ink(
                                color: ColorResources.WHITE,
                                child: ListTile(
                                  title: Text(Strings.all,
                                      style: titilliumSemiBold,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  trailing: Icon(Icons.navigate_next,
                                      color: ColorResources.BLACK),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                BrandAndCategoryProductScreen(
                                                  isBrand: false,
                                                  id: categoryProvider
                                                      .categoryList[categoryProvider
                                                          .categorySelectedIndex]
                                                      .id
                                                      .toString(),
                                                  name: categoryProvider
                                                      .categoryList[categoryProvider
                                                          .categorySelectedIndex]
                                                      .name,
                                                )));
                                  },
                                ),
                              );
                            } else if (_subCategory.subSubCategories.length !=
                                0) {
                              return Ink(
                                color: ColorResources.WHITE,
                                child: Theme(
                                  data: ThemeData(
                                      dividerColor: ColorResources.WHITE),
                                  child: ExpansionTile(
                                    key: Key(
                                        '${Provider.of<CategoryProvider>(context).categorySelectedIndex}$index'),
                                    title: Text(_subCategory.name,
                                        style: titilliumSemiBold,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                    children: _getSubSubCategories(
                                        context, _subCategory),
                                  ),
                                ),
                              );
                            } else {
                              return Ink(
                                color: ColorResources.WHITE,
                                child: ListTile(
                                  title: Text(_subCategory.name,
                                      style: titilliumSemiBold,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  trailing: Icon(Icons.navigate_next,
                                      color: ColorResources.BLACK),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                BrandAndCategoryProductScreen(
                                                  isBrand: false,
                                                  id: _subCategory.id.toString(),
                                                  name: _subCategory.name,
                                                )));
                                  },
                                ),
                              );
                            }*/
                            },
                          ),
                        ),
                      ])
                    : Center(child: CircularProgressIndicator());
              },
            )),
          ],
        ),
      ),
    );
  }

  Container buildSelectTypeContainer(String title) {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("$title",
            style: titilliumSemiBold.copyWith(
                color: ColorResources.PRIMARY_COLOR_BIT_DARK)),
      ),
    );
  }

  List<Widget> _getSubSubCategories(
      BuildContext context, SubCategory subCategory) {
    List<Widget> _subSubCategories = [];
    _subSubCategories.add(Container(
      color: ColorResources.ICON_BG,
      margin:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: ListTile(
        title: Row(
          children: [
            Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(
                  color: ColorResources.COLOR_PRIMARY, shape: BoxShape.circle),
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            Flexible(
                child: Text(Strings.all,
                    style: titilliumSemiBold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis)),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BrandAndCategoryProductScreen(
                        isBrand: false,
                        id: subCategory.id.toString(),
                        name: subCategory.name,
                      )));
        },
      ),
    ));
    for (int index = 0; index < subCategory.subSubCategories.length; index++) {
      _subSubCategories.add(Container(
        color: ColorResources.ICON_BG,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: ListTile(
          title: Row(
            children: [
              Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                    color: ColorResources.COLOR_PRIMARY,
                    shape: BoxShape.circle),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Flexible(
                  child: Text(subCategory.subSubCategories[index].name,
                      style: titilliumSemiBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis)),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BrandAndCategoryProductScreen(
                          //: "Party Wear",
                          isBrand: false,
                          id: subCategory.subSubCategories[index].id.toString(),
                          name: subCategory.subSubCategories[index].name,
                        )));
          },
        ),
      ));
    }
    return _subSubCategories;
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  CategoryItem(
      {@required this.title, @required this.icon, @required this.isSelected});

  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      margin: EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? ColorResources.COLOR_PRIMARY : null,
      ),
      child: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            /*height: 50,
            width: 50,*/
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: isSelected
                      ? ColorResources.WHITE
                      : ColorResources.HINT_TEXT_COLOR),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:
                  const SizedBox(), //CachedNetworkImage(imageUrl: icon, fit: BoxFit.fitHeight),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: titilliumSemiBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  color: isSelected
                      ? ColorResources.WHITE
                      : ColorResources.HINT_TEXT_COLOR,
                )),
          ),
        ]),
      ),
    );
  }
}
