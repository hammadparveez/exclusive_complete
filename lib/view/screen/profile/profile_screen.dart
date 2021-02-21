import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_ui_kit/data/model/response/user_info_model.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/customer_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_textfield.dart';
import 'package:sixvalley_ui_kit/view/screen/profile/widget/add_address_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  File file;
  final picker = ImagePicker();
  String fileName;
  String base64Image;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _choose() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    if (file == null) return;
    base64Image = base64Encode(file.readAsBytesSync());
    fileName = file.path.split("/").last;
  }

  _updateUserAccount() async {
    //Provider.of<ProfileProvider>(context, listen: false).uploadImage(file, Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl);
    if (Provider.of<ProfileProvider>(context, listen: false)
                .userInfoModel
                .fName ==
            _firstNameController.text &&
        Provider.of<ProfileProvider>(context, listen: false)
                .userInfoModel
                .lName ==
            _lastNameController.text &&
        Provider.of<ProfileProvider>(context, listen: false)
                .userInfoModel
                .phone ==
            _phoneController.text) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Change something to update'),
          backgroundColor: ColorResources.RED));
    } else {
      UserInfoModel updateUserInfoModel =
          Provider.of<ProfileProvider>(context, listen: false).userInfoModel;
      updateUserInfoModel.method = 'put';
      updateUserInfoModel.fName = _firstNameController.text ?? "";
      updateUserInfoModel.lName = _lastNameController.text ?? "";
      updateUserInfoModel.phone = _phoneController.text ?? '';
      /*FormData formData = new FormData.fromMap({
      "_method": "put",
      "f_name": _firstNameController.text ?? "",
      "l_name": _lastNameController.text ?? "",
      "phone": _phoneController.text ?? "",
      //"image": await MultipartFile.fromFile(file.path, filename: 'jhmfthfgh')
      });*/

      Provider.of<ProfileProvider>(context, listen: false)
          .updateUserInfo(updateUserInfoModel);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isInvalidAuth) {}
      Provider.of<CustomerProvider>(context, listen: false).initCustomerDetails(
          Provider.of<AuthProvider>(context, listen: false).getUserID());
      /*Provider.of<ProfileProvider>(context, listen: false)
          .initAddressTypeList();*/
      //Provider.of<ProfileProvider>(context, listen: false).getAddressOfUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profile-icon',
      child: Scaffold(
        key: _scaffoldKey,
        body: Provider.of<ProfileProvider>(context).isAvailableProfile
            ? Consumer3<ProfileProvider, CustomerProvider, AuthProvider>(
                builder:
                    (context, profile, customerProvider, authProvider, child) {
                  String firstName = '', lastName = '';
                  final List<String> fullName =
                      authProvider.getUserDisplayName().split(' ');
                  if (2 <= fullName.length) {
                    firstName = fullName[0];
                    lastName = fullName[1];
                  } else {
                    if (fullName.isNotEmpty) firstName = fullName[0];
                  }
                  _firstNameController.text =
                      firstName; //profile.userInfoModel.fName;
                  _lastNameController.text = lastName;
                  // profile.userInfoModel.lName;
                  _emailController.text = authProvider
                      .getUserEmail(); //profile.userInfoModel.email;
                  _phoneController.text = customerProvider
                              .wordPressCustomerModel !=
                          null
                      ? customerProvider
                          .wordPressCustomerModel.billingAddressModel.phone
                      : ""; //profile.userInfoModel.phone;; //profile.userInfoModel.phone;

                  return Stack(
                    overflow: Overflow.visible,
                    children: [
                      Image.asset(Images.toolbar_background,
                          fit: BoxFit.fill, height: 500),
                      Container(
                        padding: EdgeInsets.only(top: 35, left: 15),
                        child: Row(children: [
                          CupertinoNavigationBarBackButton(
                            onPressed: () => Navigator.of(context).pop(),
                            color: ColorResources.WHITE,
                          ),
                          SizedBox(width: 10),
                          Text(Strings.PROFILE,
                              style: titilliumRegular.copyWith(
                                  fontSize: 20, color: ColorResources.WHITE),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 55),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                AnimatedContainer(
                                  margin: EdgeInsets.only(
                                      top: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
                                  alignment: Alignment.center,
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    color: ColorResources.LIGHT_SKY_BLUE,
                                    border: Border.all(
                                        color: ColorResources.WHITE, width: 3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: customerProvider
                                                    .wordPressCustomerModel !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl: customerProvider
                                                    .wordPressCustomerModel
                                                    .avatar_url,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.fill,
                                              )
                                            : Shimmer(
                                                child: Container(height: 150),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black38,
                                                      Colors.black26,
                                                      Colors.black12
                                                    ]),
                                              ),
                                      ),
                                      /*Positioned(
                                      bottom: 0,
                                      right: -10,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            ColorResources.LIGHT_SKY_BLUE,
                                        radius: 14,
                                        child: IconButton(
                                          onPressed: _choose,
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(Icons.edit,
                                              color: ColorResources.WHITE,
                                              size: 18),
                                        ),
                                      ),
                                    ),*/
                                    ],
                                  ),
                                ),
                                Text(
                                  '${firstName} ${lastName}',
                                  style: titilliumSemiBold.copyWith(
                                      color: ColorResources.WHITE,
                                      fontSize: 20.0),
                                )
                              ],
                            ),
                            // SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                            // file == null
                            //     ? Text('No Image Selected')
                            //     : Image.file(file),

                            SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorResources.WHITE,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          Dimensions.MARGIN_SIZE_DEFAULT),
                                      topRight: Radius.circular(
                                          Dimensions.MARGIN_SIZE_DEFAULT),
                                    )),
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                                          right:
                                              Dimensions.MARGIN_SIZE_DEFAULT),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.person,
                                                      color: ColorResources
                                                          .PRIMARY_COLOR_BIT_DARK,
                                                      size: 20),
                                                  SizedBox(
                                                      width: Dimensions
                                                          .MARGIN_SIZE_EXTRA_SMALL),
                                                  Text(Strings.FIRST_NAME,
                                                      style: titilliumRegular)
                                                ],
                                              ),
                                              SizedBox(
                                                  height: Dimensions
                                                      .MARGIN_SIZE_SMALL),
                                              CustomTextField(
                                                textInputType:
                                                    TextInputType.name,
                                                focusNode: _fNameFocus,
                                                nextNode: _lNameFocus,
                                                hintText: profile
                                                        .userInfoModel.fName ??
                                                    '',
                                                controller:
                                                    _firstNameController,
                                              ),
                                            ],
                                          )),
                                          SizedBox(width: 15),
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.person,
                                                      color: ColorResources
                                                          .PRIMARY_COLOR_BIT_DARK,
                                                      size: 20),
                                                  SizedBox(
                                                      width: Dimensions
                                                          .MARGIN_SIZE_EXTRA_SMALL),
                                                  Text(Strings.LAST_NAME,
                                                      style: titilliumRegular)
                                                ],
                                              ),
                                              SizedBox(
                                                  height: Dimensions
                                                      .MARGIN_SIZE_SMALL),
                                              CustomTextField(
                                                textInputType:
                                                    TextInputType.name,
                                                focusNode: _lNameFocus,
                                                nextNode: _emailFocus,
                                                hintText:
                                                    profile.userInfoModel.lName,
                                                controller: _lastNameController,
                                              ),
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),

                                    // for Email
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: Dimensions.MARGIN_SIZE_SMALL,
                                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                                          right:
                                              Dimensions.MARGIN_SIZE_DEFAULT),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.alternate_email,
                                                  color: ColorResources
                                                      .PRIMARY_COLOR_BIT_DARK,
                                                  size: 20),
                                              SizedBox(
                                                width: Dimensions
                                                    .MARGIN_SIZE_EXTRA_SMALL,
                                              ),
                                              Text(Strings.EMAIL,
                                                  style: titilliumRegular)
                                            ],
                                          ),
                                          SizedBox(
                                              height:
                                                  Dimensions.MARGIN_SIZE_SMALL),
                                          CustomTextField(
                                            textInputType:
                                                TextInputType.emailAddress,
                                            focusNode: _emailFocus,
                                            nextNode: _phoneFocus,
                                            hintText: 'Enter an email address',
                                            controller: _emailController,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // for Phone No
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: Dimensions.MARGIN_SIZE_SMALL,
                                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                                          right:
                                              Dimensions.MARGIN_SIZE_DEFAULT),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.dialpad,
                                                  color: ColorResources
                                                      .PRIMARY_COLOR_BIT_DARK,
                                                  size: 20),
                                              SizedBox(
                                                  width: Dimensions
                                                      .MARGIN_SIZE_EXTRA_SMALL),
                                              Text(Strings.PHONE_NO,
                                                  style: titilliumRegular)
                                            ],
                                          ),
                                          SizedBox(
                                              height:
                                                  Dimensions.MARGIN_SIZE_SMALL),
                                          CustomTextField(
                                            textInputType: TextInputType.number,
                                            focusNode: _phoneFocus,
                                            hintText: "Enter a phone number ",
                                            nextNode: _addressFocus,
                                            controller: _phoneController,
                                            isPhoneNumber: true,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // for Address
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: Dimensions.MARGIN_SIZE_SMALL,
                                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                                          right:
                                              Dimensions.MARGIN_SIZE_DEFAULT),
                                      child: Column(
                                        children: [
                                          Consumer<ProfileProvider>(
                                            builder: (context, profileProvider,
                                                    child) =>
                                                Material(
                                              type: MaterialType.transparency,
                                              child: InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    isScrollControlled: true,
                                                    builder: (context) =>
                                                        AddAddressBottomSheet(),
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 25,
                                                      height: 35,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: ColorResources
                                                            .WHITE,
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 1,
                                                            blurRadius: 7,
                                                            offset: Offset(0,
                                                                1), // changes position of shadow
                                                          )
                                                        ],
                                                      ),
                                                      child: IconButton(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        icon: Icon(Icons.add,
                                                            color: ColorResources
                                                                .COLUMBIA_BLUE,
                                                            size: 20),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text("Update your address"),
                                                    /*   SizedBox(
                                                      width: Dimensions
                                                          .MARGIN_SIZE_LARGE),*/
                                                    /*   Container(
                                                    width: 25,
                                                    height: 25,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: ColorResources.WHITE,
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                          spreadRadius: 1,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              1), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: IconButton(
                                                      padding: EdgeInsets.all(0),
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AddressListScreen(
                                                                        profile
                                                                            .userInfoModel)));
                                                      },
                                                      icon: Icon(Icons.done_all,
                                                          color: ColorResources
                                                              .COLUMBIA_BLUE,
                                                          size: 18),
                                                    ),
                                                  ),*/
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  Dimensions.MARGIN_SIZE_SMALL),
                                          /*  Consumer<ProfileProvider>(
                                          builder: (context, profileProvider,
                                                  child) =>
                                              Container(
                                            width: double.infinity,
                                            height: 45,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0, horizontal: 15),
                                            decoration: BoxDecoration(
                                              color: ColorResources.WHITE,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                )
                                              ],
                                            ),
                                            child: Text(
                                                profileProvider.isHomeAddress
                                                    ? profileProvider
                                                        .getHomeAddress()
                                                    : profileProvider
                                                            .getOfficeAddress() ??
                                                        Strings
                                                            .ADDRESS_NOT_FOUND,
                                                textAlign: TextAlign.left),
                                          ),
                                        ),*/
                                        ],
                                      ),
                                    ),

                                    // for Password
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: Dimensions.MARGIN_SIZE_SMALL,
                                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                                          right:
                                              Dimensions.MARGIN_SIZE_DEFAULT),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.lock_open,
                                                  color: ColorResources
                                                      .COLOR_PRIMARY,
                                                  size: 20),
                                              SizedBox(
                                                  width: Dimensions
                                                      .MARGIN_SIZE_EXTRA_SMALL),
                                              Text(Strings.PASSWORD,
                                                  style: titilliumRegular)
                                            ],
                                          ),
                                          SizedBox(
                                              height:
                                                  Dimensions.MARGIN_SIZE_SMALL),
                                          CustomPasswordTextField(
                                            controller: _passwordController,
                                            focusNode: _passwordFocus,
                                            nextNode: _confirmPasswordFocus,
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // for  re-enter Password
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: Dimensions.MARGIN_SIZE_SMALL,
                                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                                          right:
                                              Dimensions.MARGIN_SIZE_DEFAULT),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.lock_open,
                                                  color: ColorResources
                                                      .COLOR_PRIMARY,
                                                  size: 20),
                                              SizedBox(
                                                  width: Dimensions
                                                      .MARGIN_SIZE_EXTRA_SMALL),
                                              Text(Strings.RE_ENTER_PASSWORD,
                                                  style: titilliumRegular)
                                            ],
                                          ),
                                          SizedBox(
                                              height:
                                                  Dimensions.MARGIN_SIZE_SMALL),
                                          CustomPasswordTextField(
                                            controller:
                                                _confirmPasswordController,
                                            focusNode: _confirmPasswordFocus,
                                            textInputAction:
                                                TextInputAction.done,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            /* Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.MARGIN_SIZE_LARGE,
                                vertical: Dimensions.MARGIN_SIZE_SMALL),
                            child: !Provider.of<ProfileProvider>(context)
                                    .isLoading
                                ? CustomButton(
                                    onTap: _updateUserAccount,
                                    buttonText: Strings.UPDATE_ACCOUNT)
                                : Center(child: CircularProgressIndicator()),
                          ),*/
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    ColorResources.COLOR_PRIMARY),
              )),
      ),
    );
  }
}
