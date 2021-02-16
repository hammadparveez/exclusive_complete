import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_customer_model.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';

void addressBottomSheet(BillingAddressModel userInfoModel, BuildContext context,
    Function feedbackMessage) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
            bottom: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      width: 22,
                      margin: EdgeInsets.only(
                          top: Dimensions.MARGIN_SIZE_DEFAULT,
                          bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                      height: 22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorResources.WHITE,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 1)), // changes position of shadow
                        ],
                      ),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.clear,
                          size: 18,
                          color: ColorResources.BLACK,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Provider.of<ProfileProvider>(context, listen: false)
                        .setHomeAddress();
                  },
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_DEFAULT,
                      right: Dimensions.PADDING_SIZE_DEFAULT,
                      bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    ),
                    decoration: BoxDecoration(
                        color: Provider.of<ProfileProvider>(context)
                                .checkHomeAddress
                            ? ColorResources.colorMap[50]
                            : ColorResources.HOME_BG,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: Provider.of<ProfileProvider>(context)
                                    .checkHomeAddress
                                ? ColorResources.COLUMBIA_BLUE
                                : Colors.transparent,
                            width: 2.0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/home.png',
                          width: 20,
                          height: 20,
                          color: ColorResources.COLUMBIA_BLUE,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userInfoModel.postcode} ${userInfoModel.address_1}',
                                style: titilliumSemiBold.copyWith(
                                  color: ColorResources.BLACK,
                                ),
                              ),
                              Text(
                                '${userInfoModel.phone}',
                                style: titilliumRegular.copyWith(
                                  color: ColorResources.BLACK,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/edit.png',
                          width: 20,
                          height: 20,
                          color: ColorResources.HINT_TEXT_COLOR,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Provider.of<ProfileProvider>(context, listen: false)
                        .setOfficeAddress();
                  },
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_DEFAULT,
                      right: Dimensions.PADDING_SIZE_DEFAULT,
                      bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    ),
                    decoration: BoxDecoration(
                        color: Provider.of<ProfileProvider>(context)
                                .checkOfficeAddress
                            ? ColorResources.colorMap[50]
                            : ColorResources.HOME_BG,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: Provider.of<ProfileProvider>(context)
                                    .checkOfficeAddress
                                ? ColorResources.COLUMBIA_BLUE
                                : Colors.transparent,
                            width: 2.0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/bag.png',
                          width: 20,
                          height: 20,
                          color: ColorResources.COLUMBIA_BLUE,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userInfoModel.postcode} ${userInfoModel.address_1}',
                                style: titilliumSemiBold.copyWith(
                                  color: ColorResources.BLACK,
                                ),
                              ),
                              Text(
                                '${userInfoModel.phone}',
                                style: titilliumRegular.copyWith(
                                  color: ColorResources.BLACK,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/edit.png',
                          width: 20,
                          height: 20,
                          color: ColorResources.HINT_TEXT_COLOR,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  buttonText: Strings.SAVE_ADDRESS,
                  onTap: () {
                    if (Provider.of<ProfileProvider>(context, listen: false)
                        .checkOfficeAddress) {
                      String officeAddress = userInfoModel.postcode +
                          " " +
                          userInfoModel.address_1;
                      Provider.of<ProfileProvider>(context, listen: false)
                          .saveOfficeAddress(officeAddress);
                      Navigator.of(context).pop();
                    } else if (Provider.of<ProfileProvider>(context,
                            listen: false)
                        .checkHomeAddress) {
                      String homeAddress = userInfoModel.postcode +
                          " " +
                          userInfoModel.address_1;
                      Provider.of<ProfileProvider>(context, listen: false)
                          .saveHomeAddress(homeAddress);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      });
}
