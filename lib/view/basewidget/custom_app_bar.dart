import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final isBackButtonExist;
  final IconData icon;
  final Function onActionPressed;
  final bool isOrderDone;

  CustomAppBar(
      {@required this.title,
      this.isBackButtonExist = true,
      this.icon,
      this.onActionPressed,
      this.isOrderDone = false});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        child: Image.asset(Images.toolbar_background,
            fit: BoxFit.fill, height: 90, width: double.infinity),
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: 90 - MediaQuery.of(context).padding.top,
        alignment: Alignment.center,
        child: Row(children: [
          isOrderDone
              ? IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      size: 20, color: ColorResources.WHITE),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => DashBoardScreen())),
                )
              : isBackButtonExist
                  ? IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          size: 20, color: ColorResources.WHITE),
                      onPressed: () {
                        Provider.of<ProductDetailsProvider>(context,
                                listen: false)
                            .resetQuantity();
                        Navigator.of(context).pop();
                      })
                  : SizedBox.shrink(),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: Text(
              title,
              style: titilliumRegular.copyWith(
                  fontSize: 20, color: ColorResources.WHITE),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          icon != null
              ? IconButton(
                  icon: Icon(icon,
                      size: Dimensions.ICON_SIZE_LARGE,
                      color: ColorResources.WHITE),
                  onPressed: onActionPressed,
                )
              : SizedBox.shrink(),
        ]),
      ),
    ]);
  }
}
