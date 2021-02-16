import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/provider/splash_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:provider/provider.dart';

class CurrencyDialog extends StatelessWidget {
  final bool isCurrency;
  CurrencyDialog({this.isCurrency = true});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorResources.WHITE,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(isCurrency ? Strings.currency : Strings.language, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
        ),

        SizedBox(height: 150, child: Consumer<SplashProvider>(
          builder: (context, splash, child) {
            List list = isCurrency ? splash.configModel.currencyList : splash.languageList;
            return CupertinoPicker(
              itemExtent: 40,
              useMagnifier: true,
              magnification: 1.2,
              scrollController: FixedExtentScrollController(initialItem: isCurrency ? splash.currencyIndex : splash.languageIndex),
              onSelectedItemChanged: (int index) {
                if(isCurrency) {
                  splash.setCurrencyIndex(index);
                }else {
                  splash.setLanguageIndex(index);
                }
              },
              children: list.map((value) {
                return Center(child: Text(isCurrency ? value.name : value));
              }).toList(),
            );
          },
        )),

        Divider(height: Dimensions.PADDING_SIZE_EXTRA_SMALL, color: ColorResources.HINT_TEXT_COLOR),
        Align(
          alignment: Alignment.centerRight,
          child: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Strings.CANCEL, style: robotoRegular.copyWith(color: ColorResources.YELLOW)),
          ),
        ),

      ]),
    );
  }
}