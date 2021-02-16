import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_expanded_app_bar.dart';

class HelpCenterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<String> articleList = [
      'My app isn\'t working', 'Ordered by mistake', 'Tracking is not working',
      'Tracking is not working, Ordered by mistake Ordered by mistake',
    ];

    return CustomExpandedAppBar(title: Strings.help_center, child: ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      children: [

        // Search Field
        TextField(
          style: robotoRegular,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: robotoRegular.copyWith(color: ColorResources.HINT_TEXT_COLOR),
            contentPadding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
            prefixIcon: Icon(Icons.search, color: ColorResources.COLUMBIA_BLUE),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 2, color: ColorResources.COLUMBIA_BLUE),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 2, color: ColorResources.COLUMBIA_BLUE),
            ),
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        // Recommended
        Text(Strings.recommended_articles, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: articleList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(articleList[index], style: titilliumSemiBold),
              trailing: Icon(Icons.keyboard_arrow_right, color: ColorResources.HINT_TEXT_COLOR, size: Dimensions.ICON_SIZE_DEFAULT),
            );
          },
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

        // Could not find
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Text(Strings.contact_with_customer_care, textAlign: TextAlign.center, style: titilliumSemiBold.copyWith(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: ColorResources.HINT_TEXT_COLOR,
          )),
        ),

        CustomButton(buttonText: Strings.GET_STARTED, onTap: () {}),

      ],
    ));
  }
}

