import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/provider/tracking_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/tracking/painter/line_dashed_painter.dart';
import 'package:provider/provider.dart';

class TrackingResultScreen extends StatelessWidget {
  final String orderID;
  TrackingResultScreen({@required this.orderID});

  @override
  Widget build(BuildContext context) {
    Provider.of<TrackingProvider>(context, listen: false).initTrackingInfo(orderID);
    List<String> statusList = ['pending', 'placed', 'picked', 'received', 'delivered'];

    return Scaffold(
      backgroundColor: ColorResources.ICON_BG,
      body: Column(
        children: [
          CustomAppBar(title: Strings.DELIVERY_STATUS),

          Expanded(
            child: Consumer<TrackingProvider>(
              builder: (context, tracking, child) {
                String status = tracking.trackingModel != null ? tracking.trackingModel.orderStatus : '';

                return tracking != null
                    ? statusList.contains(status) ? ListView(
                  physics: BouncingScrollPhysics(),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Strings.ESTIMATED_DELIVERY, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                              Text('7 OCT 2020', style: titilliumSemiBold.copyWith(fontSize: 20.0)),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
                            decoration: BoxDecoration(color: ColorResources.WHITE, borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for parcel status and order id section
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(Strings.PARCEL_STATUS, style: titilliumSemiBold),
                                      RichText(
                                        text: TextSpan(
                                          text: Strings.ORDER_ID,
                                          style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                          children: <TextSpan>[
                                            TextSpan(text: orderID, style: titilliumSemiBold),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                  color: ColorResources.colorMap[50],
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                // Steppers
                                CustomStepper(
                                    title: status == 'pending' ? Strings.processing : Strings.ORDER_PLACED_PREPARING,
                                    color: ColorResources.HARLEQUIN),
                                CustomStepper(
                                    title: status == 'pending'
                                        ? Strings.pending
                                        : status == 'placed' ? Strings.processing : Strings.ORDER_PICKED_SENDING,
                                    color: ColorResources.CERISE),
                                CustomStepper(
                                    title: status == 'pending'
                                        ? Strings.pending
                                        : status == 'placed'
                                            ? Strings.pending
                                            : status == 'picked' ? Strings.processing : Strings.RECEIVED_LOCAL_WAREHOUSE,
                                    color: ColorResources.COLUMBIA_BLUE),
                                CustomStepper(
                                    title: status == 'pending'
                                        ? Strings.pending
                                        : status == 'placed'
                                            ? Strings.pending
                                            : status == 'picked' ? Strings.pending : status == 'received' ? Strings.processing : Strings.DELIVERED,
                                    color: ColorResources.COLOR_PRIMARY,
                                    isLastItem: true),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Center(child: Text('Invalid order id')) : Center(child: CircularProgressIndicator());
              },
            ),
          ),

          // for footer button
          Container(
            height: 45,
            margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            decoration: BoxDecoration(color: ColorResources.IMAGE_BG, borderRadius: BorderRadius.circular(6)),
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  Strings.ORDER_MORE,
                  style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.COLOR_PRIMARY),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomStepper extends StatelessWidget {
  final String title;
  final Color color;
  final bool isLastItem;
  CustomStepper({@required this.title, @required this.color, this.isLastItem = false});

  @override
  Widget build(BuildContext context) {
    Color myColor;
    if (title == Strings.processing || title == Strings.pending) {
      myColor = ColorResources.GREY;
    } else {
      myColor = color;
    }
    return Container(
      height: isLastItem ? 50 : 100,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: CircleAvatar(backgroundColor: myColor, radius: 10.0),
              ),
              Text(title, style: titilliumRegular)
            ],
          ),
          isLastItem
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL, left: Dimensions.PADDING_SIZE_LARGE),
                  child: CustomPaint(painter: LineDashedPainter(myColor)),
                ),
        ],
      ),
    );
  }
}
