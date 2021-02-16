import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';

class AppInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.app_info, style: titilliumSemiBold.copyWith(color: ColorResources.BLACK, fontSize: Dimensions.FONT_SIZE_LARGE)),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.WHITE,
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1))],
                      ),
                      child: Icon(Icons.clear, size: 18, color: ColorResources.YELLOW)),
                ),
              ],
            ),
            Divider(thickness: .1, color: ColorResources.COLOR_PRIMARY),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.VERSION_NAME, style: titilliumRegular.copyWith(color: ColorResources.BLACK)),
                Text('654849fg.00f.00', style: titilliumSemiBold.copyWith(color: ColorResources.BLACK,fontSize: Dimensions.FONT_SIZE_LARGE)),
              ],
            ),
            Divider(thickness: .1, color: ColorResources.COLOR_PRIMARY),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.RELEASE_DATE, style: titilliumRegular.copyWith(color: ColorResources.BLACK)),
                Text('27 Oct 2020', style: titilliumSemiBold.copyWith(color: ColorResources.BLACK, fontSize: Dimensions.FONT_SIZE_LARGE)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
