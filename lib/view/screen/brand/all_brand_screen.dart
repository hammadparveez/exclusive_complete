import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/provider/brand_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/screen/home/widget/brand_view.dart';
import 'package:provider/provider.dart';

class AllBrandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.ICON_BG,
      appBar: AppBar(
        backgroundColor: ColorResources.COLOR_PRIMARY,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
        leading: Padding(
          padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
          child: CupertinoNavigationBarBackButton(color: ColorResources.WHITE, onPressed: () => Navigator.pop(context) ),
        ),
        title: Text(Strings.all_brand, style: titilliumRegular.copyWith(fontSize: 20)),
        actions: [
          PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(enabled: false, child: Text(Strings.sort_by, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.HINT_TEXT_COLOR))),
              CheckedPopupMenuItem(
                value: Strings.top_brand,
                checked: Provider.of<BrandProvider>(context, listen: false).isTopBrand,
                child: Text(Strings.top_brand, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              ),
              CheckedPopupMenuItem(
                value: Strings.alphabetically_az,
                checked: Provider.of<BrandProvider>(context, listen: false).isAZ,
                child: Text(Strings.alphabetically_az, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              ),
              CheckedPopupMenuItem(
                value: Strings.alphabetically_za,
                checked: Provider.of<BrandProvider>(context, listen: false).isZA,
                child: Text(Strings.alphabetically_za, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              ),
            ];
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          offset: Offset(0, 45),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Image.asset(Images.filter_image, color: ColorResources.WHITE),
          ),
          onSelected: (value) {
            Provider.of<BrandProvider>(context, listen: false).sortBrandLis(value);
          },
        )],
      ),

      body: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: BrandView(isHomePage: false),
      ),
    );
  }
}
