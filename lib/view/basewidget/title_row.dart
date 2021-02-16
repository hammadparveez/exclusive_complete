
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final Function onTap;
  final Duration eventDuration;
  final bool isDetailsPage;
  TitleRow({@required this.title, this.onTap, this.eventDuration, this.isDetailsPage});

  @override
  Widget build(BuildContext context) {
    int days, hours, minutes, seconds;
    if (eventDuration != null) {
      days = eventDuration.inDays;
      hours = eventDuration.inHours - days * 24;
      minutes = eventDuration.inMinutes - (24 * days * 60) - (hours * 60);
      seconds = eventDuration.inSeconds - (24 * days * 60 * 60) - (hours * 60 * 60) - (minutes * 60);
    }

    return Row(children: [
      Text(title, style: robotoBold),
      eventDuration == null
          ? Expanded(child: SizedBox.shrink())
          : Expanded(
              child: Row(children: [
              SizedBox(width: 5),
              TimerBox(time: days),
              Text(':', style: TextStyle(color: ColorResources.COLOR_PRIMARY)),
              TimerBox(time: hours),
              Text(':', style: TextStyle(color: ColorResources.COLOR_PRIMARY)),
              TimerBox(time: minutes),
              Text(':', style: TextStyle(color: ColorResources.COLOR_PRIMARY)),
              TimerBox(time: seconds, isBorder: true),
            ])),
      onTap != null
          ? InkWell(
              onTap: onTap,
              child: Row(children: [
                isDetailsPage == null
                    ? Text(Strings.VIEW_ALL,
                        style: titilliumRegular.copyWith(
                          color: ColorResources.COLOR_PRIMARY,
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                        ))
                    : SizedBox.shrink(),
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: isDetailsPage == null ? ColorResources.COLOR_PRIMARY : ColorResources.HINT_TEXT_COLOR,
                    size: Dimensions.FONT_SIZE_SMALL,
                  ),
                ),
              ]),
            )
          : SizedBox.shrink(),
    ]);
  }
}

class TimerBox extends StatelessWidget {
  final int time;
  final bool isBorder;

  TimerBox({@required this.time, this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.all(isBorder ? 0 : 2),
      decoration: BoxDecoration(
        color: isBorder ? null : ColorResources.COLOR_PRIMARY,
        border: isBorder ? Border.all(width: 2, color: ColorResources.COLOR_PRIMARY) : null,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
          child: Text(time < 10 ? '0$time' : time.toString(),
              style: robotoBold.copyWith(
                color: isBorder ? ColorResources.COLOR_PRIMARY : ColorResources.WHITE,
                fontSize: Dimensions.FONT_SIZE_SMALL,
              ))),
    );
  }
}
