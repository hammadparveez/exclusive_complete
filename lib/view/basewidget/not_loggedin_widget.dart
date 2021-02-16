import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/screen/auth/auth_screen.dart';

class NotLoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_LARGE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.PLEASE_LOGIN_FIRST, textAlign: TextAlign.center, style: robotoRegular),
              SizedBox(height: Dimensions.FONT_SIZE_DEFAULT),
              CustomButton(
                buttonText: Strings.LOGIN,
                onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen())),
              ),
            ],
          )),
    );
  }
}
