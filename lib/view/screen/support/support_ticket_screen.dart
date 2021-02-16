import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_ui_kit/data/model/response/support_ticket_model.dart';
import 'package:sixvalley_ui_kit/provider/support_ticket_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_expanded_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_screen.dart';

import 'issue_type_screen.dart';

class SupportTicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SupportTicketModel> supportTicketList;
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      supportTicketList =
          Provider.of<SupportTicketProvider>(context, listen: false)
              .supportTicketList;
      Provider.of<SupportTicketProvider>(context, listen: false)
          .getSupportTicketList();
    });

    return CustomExpandedAppBar(
      title: Strings.support_ticket,
      isGuestCheck: true,
      bottomChild: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => IssueTypeScreen())),
        child: Material(
          color: ColorResources.COLUMBIA_BLUE,
          elevation: 5,
          borderRadius: BorderRadius.circular(50),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                color: ColorResources.FLOATING_BTN,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: ColorResources.WHITE, size: 35),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(Strings.new_ticket,
                  style: titilliumSemiBold.copyWith(
                      color: ColorResources.WHITE,
                      fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
          ]),
        ),
      ),
      child: supportTicketList != null
          ? supportTicketList.length != 0
              /*Provider.of<SupportTicketProvider>(context)
                      .supportTicketList
                      .length !=
                  0*/
              ? Consumer<SupportTicketProvider>(
                  builder: (context, support, child) {
                    supportTicketList =
                        support.supportTicketList.reversed.toList();
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                      itemCount: supportTicketList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          margin: EdgeInsets.only(
                              bottom: Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            color: ColorResources.IMAGE_BG,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorResources.SELLER_TXT, width: 2),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Place date: ${supportTicketList[index].createdAt}',
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                Text(supportTicketList[index].subject,
                                    style: titilliumSemiBold),
                                Row(children: [
                                  Icon(Icons.notifications,
                                      color: ColorResources.COLOR_PRIMARY,
                                      size: 20),
                                  SizedBox(
                                      width: Dimensions.PADDING_SIZE_SMALL),
                                  Expanded(
                                      child: Text(supportTicketList[index].type,
                                          style: titilliumSemiBold)),
                                  RaisedButton(
                                    onPressed: () {},
                                    color: supportTicketList[index].status ==
                                            'solved'
                                        ? ColorResources.GREEN
                                        : ColorResources.COLOR_PRIMARY,
                                    child: Text(supportTicketList[index].status,
                                        style: titilliumSemiBold.copyWith(
                                            color: ColorResources.WHITE)),
                                  ),
                                ]),
                              ]),
                        );
                      },
                    );
                  },
                )
              : NoInternetOrDataScreen(isNoInternet: false)
          : SupportTicketShimmer(),
    );
  }
}

class SupportTicketShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: ColorResources.IMAGE_BG,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorResources.SELLER_TXT, width: 2),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled:
                Provider.of<SupportTicketProvider>(context).supportTicketList ==
                    null,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(height: 10, width: 100, color: ColorResources.WHITE),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Container(height: 15, color: ColorResources.WHITE),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Row(children: [
                Container(height: 15, width: 15, color: ColorResources.WHITE),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Container(height: 15, width: 50, color: ColorResources.WHITE),
                Expanded(child: SizedBox.shrink()),
                Container(height: 30, width: 70, color: ColorResources.WHITE),
              ]),
            ]),
          ),
        );
      },
    );
  }
}
