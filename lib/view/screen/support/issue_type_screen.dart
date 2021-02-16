import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_expanded_app_bar.dart';
import 'package:sixvalley_ui_kit/view/screen/support/add_ticket_screen.dart';

class IssueTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> issueTypeList = ['Website Problem', 'Partner request', 'Complaint', 'Info inquiry'];

    return CustomExpandedAppBar(
      title: Strings.support_ticket,
      isGuestCheck: true,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Padding(
        padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE, left: Dimensions.PADDING_SIZE_LARGE),
        child: Text(Strings.add_new_ticket, style: titilliumSemiBold.copyWith(fontSize: 20)),
      ),
      Padding(
        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, bottom: Dimensions.PADDING_SIZE_LARGE),
        child: Text(Strings.select_your_category, style: titilliumRegular),
      ),

      Expanded(child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        itemCount: issueTypeList.length,
        itemBuilder: (context, index) {
          return Container(
            color: ColorResources.LOW_GREEN,
            margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
            child: ListTile(
              leading: Icon(Icons.query_builder, color: ColorResources.COLOR_PRIMARY),
              title: Text(issueTypeList[index], style: robotoBold),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AddTicketScreen(type: issueTypeList[index])));
              },
            ),
          );
        },
      )),
    ]),
    );
  }
}
