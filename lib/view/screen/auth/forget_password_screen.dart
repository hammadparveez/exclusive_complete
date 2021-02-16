import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/animated_custom_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_textfield.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Images.background), fit: BoxFit.fill),
        ),
        child: ListView(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE), children: [

          Padding(
            padding: EdgeInsets.all(50),
            child: Image.asset(Images.logo_with_name_image, height: 150, width: 200),
          ),

          Text(Strings.FORGET_PASSWORD, style: titilliumSemiBold),

          Row(children: [
            Expanded(flex: 1, child: Divider(thickness: 1, color: ColorResources.COLOR_PRIMARY)),
            Expanded(flex: 2, child: Divider(thickness: 0.2, color: ColorResources.COLOR_PRIMARY)),
          ]),
          
          Text(Strings.lorem, style: titilliumRegular.copyWith(color: ColorResources.HINT_TEXT_COLOR, fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          CustomTextField(
            controller: _controller,
            hintText: Strings.ENTER_YOUR_EMAIL,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
          ),
          SizedBox(height: 100),

          Builder(
            builder: (context) => CustomButton(
              buttonText: Strings.send_email,
              onTap: () {

                if(_controller.text.isEmpty) {
                  showCustomSnackBar(Strings.EMAIL_MUST_BE_REQUIRED, context);
                }else {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  _controller.clear();

                  showAnimatedDialog(context, AlertDialog(
                    title: Text('Successful', style: titilliumBold.copyWith(
                      color: ColorResources.COLOR_PRIMARY,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    )),
                    content: RichText(text: TextSpan(children: <TextSpan>[
                      TextSpan(text:'An email sent to ', style: titilliumRegular.copyWith(color: ColorResources.GREEN)),
                      TextSpan(text: _controller.text, style: titilliumBold.copyWith(color: ColorResources.GREEN)),
                      TextSpan(
                        text: '. Please check your mail and change password with given url.',
                        style: titilliumRegular.copyWith(color: ColorResources.GREEN),
                      ),
                    ])),
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    actions: [
                      RaisedButton(
                        onPressed: () => Navigator.pop(context),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        color: ColorResources.COLOR_PRIMARY,
                        child: Text("Ok", style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: ColorResources.WHITE,
                        )),
                      ),
                    ],
                  ), dismissible: false, isFlip: true);
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
