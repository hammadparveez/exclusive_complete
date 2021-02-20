import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/redirect_check.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/customer_provider.dart';
import 'package:sixvalley_ui_kit/provider/order_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/screen/auth/auth_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/profile/widget/add_address_bottom_sheet.dart';

class AddressBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.getAddressOfUser();
      if (profileProvider.addressList != null) {
        final country = profileProvider.addressList.isNotEmpty
            ? profileProvider.addressList.first.country
            : null;
        print("Countryies Models ${profileProvider.countryModel}");
        String countryCode = "";
        try {
          countryCode = profileProvider.countryModel.keys.firstWhere((element) {
            print("Country matched or not ${element}");

            return profileProvider.countryModel[element] == country;
          });
          print("My Country Code is ${countryCode}");
          profileProvider.updateShipping(countryCode: countryCode);
        } catch (error) {
          print("Country not found ${error}");
        }
      }
    });

    return Consumer2<AuthProvider, ProfileProvider>(
      builder: (_, authProvider, profileProvider, child) => Container(
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // Close Button
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.WHITE,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            spreadRadius: 3,
                            blurRadius: 10)
                      ]),
                  child: Icon(Icons.clear,
                      color: ColorResources.BLACK,
                      size: Dimensions.ICON_SIZE_SMALL),
                ),
              ),
            ),

            Consumer2<ProfileProvider, CustomerProvider>(
              builder: (context, profile, customer, child) {
                print(
                    "This is my bottom sheet ${profile.addressList} and ${profile.addressList} and ${Provider.of<OrderProvider>(context).addressIndex}");
                return profileProvider.addressList != null
                    ? !profileProvider.isAddressLoading
                        ? profile.addressList.length != 0
                            ? SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  itemCount:
                                      profile.addressList.length > 0 ? 1 : 0,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    print(
                                        "My Address List ${profileProvider.addressList}");
                                    final billingModel =
                                        profileProvider.addressList.isNotEmpty
                                            ? profileProvider.addressList[0]
                                            : null;
                                    print(
                                        "My Selected index is ${Provider.of<OrderProvider>(context).addressIndex}");
                                    print(
                                        "My Selected index 22 is ${profileProvider.selectedIndexValue}");

                                    return InkWell(
                                      onTap: () {
                                        if (billingModel != null)
                                          Provider.of<OrderProvider>(context,
                                                  listen: false)
                                              .setAddressIndex(index);
                                        print(
                                            "My country Cde on tap ${Provider.of<ProfileProvider>(context, listen: false).countrySelectedCode}");
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: Dimensions.PADDING_SIZE_SMALL),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorResources.ICON_BG,
                                          border: (index) ==
                                                  Provider.of<OrderProvider>(
                                                          context)
                                                      .addressIndex
                                              ? Border.all(
                                                  width: 2,
                                                  color: ColorResources
                                                      .COLOR_PRIMARY)
                                              : null,
                                        ),
                                        child: ListTile(
                                          leading: Image.asset(
                                            Images.home_image,
                                            /*profile.addressList[index].addressType ==
                                                'Home'
                                            ? Images.home_image
                                            : profile.addressList[index]
                                                        .addressType ==
                                                    'Ofice'
                                                ? Images.bag
                                                : Images.more_image,*/
                                            color: ColorResources.SELLER_TXT,
                                            height: 30,
                                            width: 30,
                                          ),
                                          title: profile.addressList[index] !=
                                                  null
                                              ? Text(
                                                  "${profile.addressList[index].address_1} ${profile.addressList[index].city} ${profile.addressList[index].postcode} ${profile.addressList[index].country} ",
                                                  style: titilliumRegular)
                                              : authProvider.isInvalidAuth
                                                  ? Text("Add your Address")
                                                  : Text(
                                                      "You must be signed in to add new address"),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text("No Address available"),
                              )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                    : const SizedBox.shrink();
              },
            ),

            CustomButton(
                buttonText: authProvider.isInvalidAuth
                    ? Strings.add_new_address
                    : "Sign In",
                onTap: () {
                  if (authProvider.isInvalidAuth) {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => AddAddressBottomSheet(),
                    );
                  } else {
                    print("Im inside else button");
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AuthScreen(
                                redirect: RedirectionCheck.isCheckout,
                              )),
                    );
                    /*showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => AddAddressBottomSheet(),
                    );*/
                  }
                }),
          ]),
        ),
      ),
    );
  }
}
