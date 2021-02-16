import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/user_info_model.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_screen.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/screen/profile/widget/select_address_bottomsheet.dart';

class AddressListScreen extends StatelessWidget {
  final UserInfoModel userInfoModel;
  AddressListScreen(this.userInfoModel);

  @override
  Widget build(BuildContext context) {
    feedbackMessage(String message) {
      showCustomSnackBar(message, context);
    }

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: Strings.ADDRESS_LIST),
          Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              return profileProvider.addressList != null
                  ? profileProvider.addressList.length > 0
                      ? Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            itemCount: profileProvider.addressList.length,
                            itemBuilder: (context, index) => Card(
                              child: ListTile(
                                onTap: () {
                                  addressBottomSheet(
                                      profileProvider.addressList[index],
                                      context,
                                      feedbackMessage);
                                },
                                title: Text(
                                    'Address: ${profileProvider.addressList[index].address_1}' ??
                                        ""),
                                subtitle: Row(
                                  children: [
                                    Text(
                                        'City: ${profileProvider.addressList[index].city ?? ""},'),
                                    const SizedBox(width: 5),
                                    Text(
                                        'State: ${profileProvider.addressList[index].state ?? ""}'),
                                    const SizedBox(width: 5),
                                    Text(
                                        'Country: ${profileProvider.addressList[index].country ?? ""}'),
                                  ],
                                ),
                                /*trailing: IconButton(
                                  icon: Icon(Icons.delete_forever,
                                      color: Colors.red),
                                  onPressed: () {
                                    showCustomModalDialog(
                                      context,
                                      title: Strings.REMOVE_ADDRESS,
                                      content: profileProvider
                                          .addressList[index].address_1,
                                      cancelButtonText: Strings.CANCEL,
                                      submitButtonText: Strings.REMOVE,
                                      submitOnPressed: () {
                                        Provider.of<ProfileProvider>(context, listen: false)
                                    .removeAddressById(profileProvider.addressList[index].id, index);

                                        Navigator.of(context).pop();
                                      },
                                      cancelOnPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                ),*/
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: NoInternetOrDataScreen(isNoInternet: false))
                  : Expanded(child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    );
  }
}
