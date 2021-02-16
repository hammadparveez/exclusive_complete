import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_textfield.dart';
import 'package:sixvalley_ui_kit/view/screen/tracking/tracking_result_screen.dart';

class TrackingScreen extends StatelessWidget {
  final TextEditingController _orderIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _orderIdController.text = '10001';

    return Scaffold(
      backgroundColor: ColorResources.ICON_BG,
      body: Column(
        children: [
          CustomAppBar(title: Strings.TRACKING),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Image.asset(
                        'assets/images/onboarding_image_one.png',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.30,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                      Text(Strings.TRACK_ORDER, style: robotoBold),
                      Stack(children: [
                        Container(
                          width: double.infinity,
                          height: 1,
                          margin: EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
                          color: ColorResources.colorMap[50],
                        ),
                        Container(
                          width: 70,
                          height: 1,
                          margin: EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
                          decoration: BoxDecoration(color: ColorResources.COLOR_PRIMARY, borderRadius: BorderRadius.circular(1)),
                        ),
                      ]),
                      SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_LARGE),

                      CustomTextField(hintText: Strings.TRACK_ID, textInputType: TextInputType.number, controller: _orderIdController),
                      SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                      CustomTextField(hintText: Strings.PHONE_NUMBER, textInputType: TextInputType.phone, textInputAction: TextInputAction.done),
                      SizedBox(height: 50),

                      Builder(
                        builder: (context) => CustomButton(
                          buttonText: Strings.TRACK,
                          onTap: () {
                            if(_orderIdController.text.isNotEmpty){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackingResultScreen(orderID: _orderIdController.text)));
                            }else {
                              showCustomSnackBar('Insert track ID', context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
