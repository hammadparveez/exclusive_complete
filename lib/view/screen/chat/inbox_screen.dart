import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/seller_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_screen.dart';
import 'package:sixvalley_ui_kit/view/basewidget/not_loggedin_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/chat/chat_screen.dart';

// ignore: must_be_immutable
class InboxScreen extends StatelessWidget {
  final bool isBackButtonExist;
  InboxScreen({this.isBackButtonExist = true});

  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isFirstTime) {
        Provider.of<SellerProvider>(context, listen: false).initSeller('4');
        isFirstTime = false;
      }
      isGuestMode =
          !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
      print("Check Guest Mode ${isGuestMode} }");
    });
    return Scaffold(
      backgroundColor: ColorResources.ICON_BG,
      body: Column(children: [
        // AppBar
        Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
            child: Image.asset(Images.toolbar_background,
                fit: BoxFit.fill, height: 90, width: double.infinity),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            height: 90 - MediaQuery.of(context).padding.top,
            alignment: Alignment.center,
            child: Row(children: [
              isBackButtonExist
                  ? IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          size: 20, color: ColorResources.WHITE),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  : SizedBox.shrink(),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                child: Provider.of<SellerProvider>(context).isSearching
                    ? TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                          hintStyle: titilliumRegular.copyWith(
                              color: ColorResources.GAINS_BORO),
                        ),
                        style: titilliumSemiBold.copyWith(
                            color: ColorResources.WHITE,
                            fontSize: Dimensions.FONT_SIZE_LARGE),
                        onChanged: (String query) {
                          Provider.of<SellerProvider>(context, listen: false)
                              .filterList(query);
                        },
                      )
                    : Text(
                        Strings.inbox,
                        style: titilliumRegular.copyWith(
                            fontSize: 20, color: ColorResources.WHITE),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
              IconButton(
                icon: Icon(
                  Provider.of<SellerProvider>(context).isSearching
                      ? Icons.close
                      : Icons.search,
                  size: Dimensions.ICON_SIZE_LARGE,
                  color: ColorResources.WHITE,
                ),
                onPressed: () =>
                    Provider.of<SellerProvider>(context, listen: false)
                        .toggleSearch(),
              ),
            ]),
          ),
        ]),
        Consumer<AuthProvider>(
          builder: (ctx, authProvider, child) {
            print("Gues Mode");
            return !authProvider.isUserLoggedIn
                ? NotLoggedInWidget()
                : Expanded(
                    child: Provider.of<SellerProvider>(context).sellerList !=
                            null
                        ? Provider.of<SellerProvider>(context)
                                    .sellerList
                                    .length !=
                                0
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: Provider.of<SellerProvider>(context)
                                    .sellerList
                                    .length,
                                padding: EdgeInsets.all(0),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                            child: Icon(Icons.person),
                                            radius: 30),
                                        title: Text(
                                            Provider.of<SellerProvider>(context)
                                                    .sellerList[index]
                                                    .fName +
                                                ' ' +
                                                Provider.of<SellerProvider>(
                                                        context)
                                                    .sellerList[index]
                                                    .lName,
                                            style: titilliumSemiBold),
                                        subtitle: Text('When will you start?',
                                            style: titilliumRegular.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_SMALL)),
                                        trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('16:12:18',
                                                  style: titilliumRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_EXTRA_SMALL)),
                                              SizedBox(
                                                  height: Dimensions
                                                      .PADDING_SIZE_SMALL),
                                              Container(
                                                height: 20,
                                                width: 20,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: ColorResources
                                                      .COLOR_PRIMARY,
                                                ),
                                                child: Text('3',
                                                    style: titilliumSemiBold
                                                        .copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_EXTRA_SMALL,
                                                            color:
                                                                ColorResources
                                                                    .WHITE)),
                                              ),
                                            ]),
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ChatScreen(
                                                      seller: Provider.of<
                                                                  SellerProvider>(
                                                              context)
                                                          .sellerList[index],
                                                    ))),
                                      ),
                                      Divider(
                                          height: 2,
                                          color:
                                              ColorResources.CHAT_ICON_COLOR),
                                    ],
                                  );
                                },
                              )
                            : NoInternetOrDataScreen(isNoInternet: false)
                        : InboxShimmer(),
                  );
          },
        ),
      ]),
    );
  }
}

class InboxShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: Provider.of<SellerProvider>(context).sellerList == null,
          child: Padding(
            padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
            child: Row(children: [
              CircleAvatar(child: Icon(Icons.person), radius: 30),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [
                    Container(height: 15, color: ColorResources.WHITE),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Container(height: 15, color: ColorResources.WHITE),
                  ]),
                ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(height: 10, width: 30, color: ColorResources.WHITE),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.COLOR_PRIMARY),
                ),
              ])
            ]),
          ),
        );
      },
    );
  }
}
