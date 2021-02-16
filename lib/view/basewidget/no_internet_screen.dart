import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';

class NoInternetOrDataScreen extends StatelessWidget {
  final bool isNoInternet;
  NoInternetOrDataScreen({@required this.isNoInternet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(isNoInternet ? Images.no_internet : Images.no_data,
                width: 150, height: 150),
            Text(isNoInternet ? Strings.OPPS : Strings.sorry,
                style: titilliumBold.copyWith(
                  fontSize: 30,
                  color: isNoInternet
                      ? ColorResources.BLACK
                      : ColorResources.COLUMBIA_BLUE,
                )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text(
              isNoInternet ? 'No internet connection' : 'No data found',
              textAlign: TextAlign.center,
              style: titilliumRegular,
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
