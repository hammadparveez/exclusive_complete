import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/address_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_customer_model.dart';
import 'package:sixvalley_ui_kit/provider/order_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_textfield.dart';

class AddAddressBottomSheet extends StatefulWidget {
  @override
  _AddAddressBottomSheetState createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  final FocusNode _addr1Focus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _zipCodeFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _addr2Focus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _phone = FocusNode();

  final TextEditingController _buttonSheetAddressController =
      TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _addr1Controller = TextEditingController();
  final TextEditingController _addr2Controller = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> countryModels;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false).fetchRegion();

      countryModels =
          Provider.of<ProfileProvider>(context, listen: false).countryModel;
    });
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT,
          bottom: Dimensions.PADDING_SIZE_DEFAULT,
          top: Get.mediaQuery.padding.top + 5),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                /*Consumer4<ProfileProvider, AuthProvider, CustomerProvider,
                    OrderProvider>(
                  builder: (context, profileProvider, authProvider,
                      customerProvider, orderProvider, child) {
                    //profileProvider.
                    final billingAddr = customerProvider
                        .wordPressCustomerModel.billingAddressModel;
                    _cityNameController.text = billingAddr.city;
                    _buttonSheetAddressController.text = billingAddr.address_1;
                    _zipCodeController.text = billingAddr.postcode;
                    return Container(
                      padding: EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        right: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 1), // changes position of shadow
                          )
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6)),
                      ),
                      alignment: Alignment.center,
                      child: DropdownButtonFormField<String>(
                        value: profileProvider.addressType,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: ColorResources.COLOR_PRIMARY),
                        decoration: InputDecoration(border: InputBorder.none),
                        iconSize: 24,
                        elevation: 16,
                        style: titilliumRegular.copyWith(
                            color: ColorResources.BLACK.withOpacity(.5)),
                        validator: (value) => value == 'Select Address type'
                            ? 'field required'
                            : null,
                        //underline: SizedBox(),

                        onChanged: profileProvider.updateCountryCode,
                        items: profileProvider.addressTypeList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),*/
                //Divider(thickness: 0.7, color: ColorResources.GREY),
                CustomTextField(
                  hintText: Strings.ENTER_YOUR_ADDRESS_1,
                  controller: _addr1Controller,
                  textInputType: TextInputType.streetAddress,
                  focusNode: _addr1Focus,
                  nextNode: _addr2Focus,
                  isValidator: true,
                  validatorMessage: Strings.ADDRESS_FIELD_MUST_BE_REQUIRED,
                  textInputAction: TextInputAction.next,
                ),
                Divider(thickness: 0.7, color: ColorResources.GREY),
                CustomTextField(
                  hintText: Strings.ENTER_YOUR_ADDRESS_2,
                  controller: _addr2Controller,
                  textInputType: TextInputType.streetAddress,
                  focusNode: _addr2Focus,
                  nextNode: _cityFocus,
                  isValidator: false,
                  validatorMessage: Strings.ADDRESS_FIELD_MUST_BE_REQUIRED,
                  textInputAction: TextInputAction.next,
                ),
                Divider(thickness: 0.7, color: ColorResources.GREY),

                CustomTextField(
                  hintText: Strings.ENTER_YOUR_CITY,
                  controller: _cityNameController,
                  textInputType: TextInputType.streetAddress,
                  focusNode: _cityFocus,
                  isValidator: true,
                  validatorMessage: Strings.CITY_FIELD_MUST_BE_REQUIRED,
                  nextNode: _zipCodeFocus,
                  textInputAction: TextInputAction.next,
                ),
                Divider(thickness: 0.7, color: ColorResources.GREY),
                CustomTextField(
                  hintText: Strings.ENTER_YOUR_ZIP_CODE,
                  isPhoneNumber: true,
                  controller: _zipCodeController,
                  textInputType: TextInputType.number,
                  focusNode: _zipCodeFocus,
                  isValidator: true,
                  nextNode: _countryFocus,
                  validatorMessage: Strings.ZIPCODE_FIELD_MUST_BE_REQUIRED,
                  textInputAction: TextInputAction.done,
                ),
                Divider(thickness: 0.7, color: ColorResources.GREY),
                Consumer<ProfileProvider>(builder: (_, profileProvider, child) {
                  String selectedRegion;
                  return DropdownButtonFormField(
                    items: profileProvider.countryModel != null
                        ? profileProvider.countryModel.keys
                            .map<DropdownMenuItem>((e) => DropdownMenuItem(
                                  child: Text(
                                      "${profileProvider.countryModel[e]}"),
                                  value: e,
                                ))
                            .toList()
                        : [],
                    /*for (String key, dynamic value in profileProvider.countryModel)
                        DropdownMenuItem(
                          child: Text("${model.name}"),
                          value: model.countryId,
                        ),*/
                    onChanged: (value) async {
                      profileProvider.countrySelectedCode = value;
                      await profileProvider.updateShipping(countryCode: value);
                      //profileProvider.fetchRegionMethods(value);
                    },
                    isExpanded: true,
                    autovalidate: true,
                    value: profileProvider.countrySelectedCode,
                    hint: Text("Select Your Region"),
                  );
                }),

                Divider(thickness: 0.7, color: ColorResources.GREY),
                CustomTextField(
                  hintText: Strings.ENTER_YOUR_STATE,
                  controller: _stateController,
                  textInputType: TextInputType.streetAddress,
                  focusNode: _stateFocus,
                  isValidator: true,
                  validatorMessage:
                      "Enter A State", //Strings.CITY_FIELD_MUST_BE_REQUIRED,
                  nextNode: _phone,
                  textInputAction: TextInputAction.next,
                ),
                Divider(thickness: 0.7, color: ColorResources.GREY),
                CustomTextField(
                  hintText: Strings.ENTER_MOBILE_NUMBER,
                  controller: _phoneController,
                  textInputType: TextInputType.number,
                  focusNode: _phone,
                  isValidator: true, isPhoneNumber: true,

                  validatorMessage:
                      "Enter A Phone Number", //Strings.CITY_FIELD_MUST_BE_REQUIRED,

                  textInputAction: TextInputAction.next,
                ),
                Divider(thickness: 0.7, color: ColorResources.GREY),

                Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) {
                    return profileProvider.isLoading
                        ? CircularProgressIndicator(key: Key(''))
                        : CustomButton(
                            buttonText: Strings.UPDATE_ADDRESS,
                            onTap: () {
                              _addAddress();
                            },
                          );
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addAddress() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AddressModel addressModel = AddressModel();
      addressModel.contactPersonName = 'x';
      addressModel.addressType =
          Provider.of<ProfileProvider>(context, listen: false).addressType;
      addressModel.city = _cityNameController.text;
      addressModel.address = _buttonSheetAddressController.text;
      addressModel.zip = _zipCodeController.text;
      addressModel.phone = _phoneController.text;
      final billingAddress = BillingAddressModel(
        address_1: _addr1Controller.text,
        address_2: _addr2Controller.text,
        city: _cityNameController.text,
        postcode: _zipCodeController.text,
        country:
            Provider.of<ProfileProvider>(context, listen: false).countryModel[
                Provider.of<ProfileProvider>(context, listen: false)
                    .countrySelectedCode],
        phone: _phoneController.text,
        state: _stateController.text,
      );

      showDialog(
          context: context,
          builder: (_) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Material(
                type: MaterialType.transparency,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    const SizedBox(height: 10),
                    Text("Updating address",
                        style: titilliumSemiBold.copyWith(
                            color: ColorResources.WHITE)),
                  ],
                )),
              ),
            );
          },
          barrierDismissible: false);
      Provider.of<ProfileProvider>(context, listen: false).resetAddressList();
      Provider.of<ProfileProvider>(context, listen: false)
          .isAddingAddressLoader = true;
      await Provider.of<ProfileProvider>(context, listen: false)
          .addAddress(null, billingAddress);
      final countryCode = Provider.of<ProfileProvider>(context, listen: false)
          .countrySelectedCode;
      print("Country Code is : $countryCode");
      await Provider.of<ProfileProvider>(context, listen: false)
          .updateShipping(countryCode: countryCode);
      print("Country Code is 2: $countryCode");
      await Provider.of<ProfileProvider>(context, listen: false)
          .updateShipping(countryCode: countryCode);
      if (Provider.of<ProfileProvider>(context, listen: false)
                  .addressList
                  .length >
              0 &&
          Provider.of<ProfileProvider>(context, listen: false)
              .addressList
              .first
              .address_1
              .isNotEmpty)
        Provider.of<OrderProvider>(context, listen: false).setAddressIndex(0);
      print("Country Code is 3: $countryCode");
      if (Provider.of<ProfileProvider>(context, listen: false).isShippingLoaded)
        Navigator.pop(context);
      if (!Provider.of<ProfileProvider>(context, listen: false)
          .isAddingAddressLoader) {
        Navigator.pop(context);
        Navigator.pop(context);
      } else
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content:
                      Text("Something went wrong, Please add correct address"),
                ));
    }
  }

  route(bool isRoute, String message) {
    if (isRoute) {
      _cityNameController.clear();
      _zipCodeController.clear();
      Navigator.pop(context);
    }
  }
}
