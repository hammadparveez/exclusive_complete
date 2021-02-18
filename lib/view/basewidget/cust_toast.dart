import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';

customToastDialog({@required BuildContext context, @required String title, Duration duration = const Duration(seconds: 2)}) {
showDialog(
context: context,
barrierColor: Colors.transparent,
barrierDismissible: false,
builder: (_) {
return Material(
type: MaterialType.transparency,
child: Center(
heightFactor: .5,
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
  const SizedBox(height: 10),
Container(
padding:
EdgeInsets.symmetric(vertical: 5, horizontal: 5),
alignment: Alignment.center,
width: Get.width / 1.5,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(5),
color: ColorResources.PRIMARY_COLOR_BIT_DARK),
child: Text(title,
style: titilliumSemiBold.copyWith(
color: ColorResources.WHITE)),
),
  const SizedBox(height: 10),
],
),
),
);
});
Future.delayed(duration, () => Get.back());
}
