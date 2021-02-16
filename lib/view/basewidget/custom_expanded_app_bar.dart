import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/basewidget/not_loggedin_widget.dart';

class CustomExpandedAppBar extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget bottomChild;
  final bool isGuestCheck;
  CustomExpandedAppBar(
      {@required this.title,
      @required this.child,
      this.bottomChild,
      this.isGuestCheck = false});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isGuestMode =
          !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    });

    return Scaffold(
      floatingActionButton: bottomChild,
      body: Stack(children: [
        // Background
        Positioned(
          left: 0,
          right: 0,
          child: Image.asset(Images.more_page_header, height: 150),
        ),

        Positioned(
          top: 40,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Row(children: [
            CupertinoNavigationBarBackButton(
                color: ColorResources.WHITE,
                onPressed: () => Navigator.pop(context)),
            Text(title,
                style: titilliumRegular.copyWith(
                    fontSize: 20, color: ColorResources.WHITE),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ]),
        ),

        Container(
          margin: EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            //color: ColorResources.WHITE,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: isGuestCheck
              ? isGuestMode
                  ? NotLoggedInWidget()
                  : child
              : child,
        ),
      ]),
    );
  }
}
