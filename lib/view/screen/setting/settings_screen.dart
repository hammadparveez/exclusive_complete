import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/splash_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/animated_custom_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_expanded_app_bar.dart';
import 'package:sixvalley_ui_kit/view/screen/setting/widget/currency_dialog.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomExpandedAppBar(
        title: Strings.settings,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(
                top: Dimensions.PADDING_SIZE_LARGE,
                left: Dimensions.PADDING_SIZE_LARGE),
            child: Text(Strings.settings,
                style: titilliumSemiBold.copyWith(
                    fontSize: Dimensions.FONT_SIZE_LARGE)),
          ),
          Expanded(
              child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            children: [
              TitleButton(
                image: Images.language,
                title: Strings.choose_language,
                onTap: () => showAnimatedDialog(
                    context, CurrencyDialog(isCurrency: false)),
              ),
              TitleButton(
                image: Images.currency,
                title:
                    '${Strings.currency} (${Provider.of<SplashProvider>(context).currency.name})',
                onTap: () => showAnimatedDialog(context, CurrencyDialog()),
              ),
            ],
          )),
        ]));
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;
  TitleButton(
      {@required this.image, @required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image,
          width: 25,
          height: 25,
          fit: BoxFit.fill,
          color: ColorResources.COLOR_PRIMARY),
      title: Text(title,
          style:
              titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: onTap,
    );
  }
}
