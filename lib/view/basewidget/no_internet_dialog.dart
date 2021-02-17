import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';

class NoInterNetDialog extends StatelessWidget {
 final bool isDoubleBack, singleBack;
  const NoInterNetDialog({Key key, this.isDoubleBack =false, this.singleBack = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(isDoubleBack) {
          Get.back();
          Get.back();
        }else if(singleBack){
          Get.back();
        }
        return true;
      },
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Hero(tag: AppConstants.TAG_NET_DIALOG ,child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: Image.asset(Images.no_internet)),
                const SizedBox(height: 10),
                Container(width: Get.width/1.5,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_SMALL),
                  decoration: BoxDecoration(
                    color: ColorResources.BLACK.withOpacity(.8),
                    borderRadius: BorderRadius.circular(8),
                  ), child: Text(Strings.NO_INTERNET, textAlign: TextAlign.center, style: titilliumSemiBold.copyWith(color: ColorResources.WHITE,),),),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
