import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String buttonText;
  final Color color;
  CustomButton({this.onTap, @required this.buttonText, this.color});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      padding: EdgeInsets.all(0),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 1)), // changes position of shadow
            ],
            gradient: LinearGradient(colors: [
              color ?? ColorResources.PRIMARY_COLOR,
              color ?? ColorResources.PRIMARY_COLOR,
            ]),
            borderRadius: BorderRadius.circular(10)),
        child: Text(buttonText,
            style: titilliumSemiBold.copyWith(
              fontSize: 16,
              color: ColorResources.WHITE,
            )),
      ),
    );
  }
}
