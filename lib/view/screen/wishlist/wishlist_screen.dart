import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/search_provider.dart';
import 'package:sixvalley_ui_kit/provider/wishlist_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_screen.dart';
import 'package:sixvalley_ui_kit/view/basewidget/not_loggedin_widget.dart';
import 'package:sixvalley_ui_kit/view/basewidget/search_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/wishlist/widget/wishlist_widget.dart';

class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isGuestMode = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isGuestMode =
          !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    });
    return Scaffold(
      backgroundColor: ColorResources.ICON_BG,
      //resizeToAvoidBottomPadding: true,
      body: Column(
        children: [
          SearchWidget(
            hintText: 'Search wishlist...',
            onTextChanged: (query) {
              Provider.of<WishListProvider>(context, listen: false)
                  .searchWishList(query);
            },
            onClearPressed: () {
              Provider.of<SearchProvider>(context, listen: false)
                  .setSearchText('');
            },
          ),
          isGuestMode
              ? NotLoggedInWidget()
              : Expanded(
                  child: Consumer<WishListProvider>(
                    builder: (context, wishListProvider, child) {
                      print("WishList ${wishListProvider.wishList}");
                      return wishListProvider.wishList != null
                          ? wishListProvider.wishList.length != 0
                              ? ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(0),
                                  itemCount: wishListProvider.wishList.length,
                                  itemBuilder: (context, index) {
                                    print(
                                        "Wist List  ${wishListProvider.wishList}");
                                    return WishListWidget(
                                      wordPressProductModel:
                                          wishListProvider.wishList[index],
                                      //product: wishListProvider.wishList[index],
                                      index: index,
                                    );
                                  })
                              : NoInternetOrDataScreen(isNoInternet: false)
                          : WishListShimmer();
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class WishListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: Provider.of<WishListProvider>(context).allWishList == null,
          child: ListTile(
            leading:
                Container(height: 50, width: 50, color: ColorResources.WHITE),
            title: Container(height: 20, color: ColorResources.WHITE),
            subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 10, width: 70, color: ColorResources.WHITE),
                  Container(height: 10, width: 20, color: ColorResources.WHITE),
                  Container(height: 10, width: 50, color: ColorResources.WHITE),
                ]),
            trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: ColorResources.WHITE)),
                  SizedBox(height: 10),
                  Container(height: 10, width: 50, color: ColorResources.WHITE),
                ]),
          ),
        );
      },
    );
  }
}
