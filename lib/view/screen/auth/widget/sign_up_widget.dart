import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/body/register_model.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_textfield.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as loader;
class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey;

  FocusNode _fNameFocus = FocusNode();
  FocusNode _lNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _userNameFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();

  RegisterModel register = RegisterModel();
  bool isEmailVerified = false;

  addUser() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      isEmailVerified = true;

      if (_firstNameController.text.isEmpty) {
        showCustomSnackBar(Strings.NAME_FIELD_MUST_BE_REQUIRED, context);
      } else if (_emailController.text.isEmpty) {
        showCustomSnackBar(Strings.EMAIL_MUST_BE_REQUIRED, context);
      } else if (_userNameController.text.isEmpty) {
        showCustomSnackBar(Strings.USERNAME_REQUIERED, context);
      } else if (_passwordController.text.isEmpty) {
        showCustomSnackBar(Strings.PASSWORD_MUST_BE_REQUIRED, context);
      } else if (_confirmPasswordController.text.isEmpty) {
        showCustomSnackBar(Strings.CONFIRM_PASSWORD_MUST_BE_REQUIRED, context);
      } else if (_passwordController.text != _confirmPasswordController.text) {
        showCustomSnackBar(Strings.PASSWORD_DID_NOT_MATCH, context);
      } else {
        register.fName = '${_firstNameController.text}';
        register.lName = _lastNameController.text ?? " ";
        register.email = _emailController.text;
        register.userName = _userNameController.text;
        register.password = _passwordController.text;
        final registerModel = RegisterModel(
          email: _emailController.text,
          password: _passwordController.text,
          fName: _firstNameController.text,
          lName: _lastNameController.text,
          userName: _userNameController.text,
        );
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Text("Please wait..."),
              ],
            ),
          ),
        );
        Provider.of<AuthProvider>(context, listen: false)
            .register(registerModel)
            .then((isLoggedIn) async {
          if (isLoggedIn) {

            Provider.of<ProfileProvider>(context, listen: false)
                .assignEmptyAddressList();
            Provider.of<ProfileProvider>(context, listen: false)
                .getAddressOfUser();
            Navigator.pop(context);
            Provider.of<AuthProvider>(context, listen: false).updateSelectedIndex(0);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
              return DashBoardScreen();
            }), (route) => false);
          } else {
            print("Else Condition");
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                actions: [
                  FlatButton(
                      onPressed: () => Get.back(),
                      child: Text("Close", style: titilliumSemiBold))
                ],
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Username/Email already exists"),
                  ],
                ),
              ),
            );
          }
        }).catchError((error) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              actions: [
                FlatButton(
                    onPressed: () => Get.back(),
                    child: Text("Close", style: titilliumSemiBold))
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Something went wrong"),
                ],
              ),
            ),
          );
        });

        /* Provider.of<AuthProvider>(context, listen: false)
            .registration(register);*/
        /*Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ConfirmationScreen()));*/

        _emailController.clear();
        _passwordController.clear();
        _firstNameController.clear();
        _lastNameController.clear();
        _userNameController.clear();
        _confirmPasswordController.clear();
      }
    } else {
      isEmailVerified = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              // for first and last name
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      hintText: Strings.FIRST_NAME,
                      textInputType: TextInputType.name,
                      focusNode: _fNameFocus,
                      nextNode: _lNameFocus,
                      isPhoneNumber: false,
                      controller: _firstNameController,
                    )),
                    SizedBox(width: 15),
                    Expanded(
                        child: CustomTextField(
                      hintText: Strings.LAST_NAME,
                      focusNode: _lNameFocus,
                      nextNode: _emailFocus,
                      controller: _lastNameController,
                    )),
                  ],
                ),
              ),

              // for email
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_LARGE),
                child: CustomTextField(
                  hintText: Strings.ENTER_YOUR_EMAIL,
                  focusNode: _emailFocus,
                  nextNode: _userNameFocus,
                  isValidator: true,
                  validatorMessage: Strings.PLEASE_PROVIDE_A_VALID_EMAIL,
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                  doValidate: (value) {
 final regex=                   RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
 final isEmailValid = regex.hasMatch(value);
                    if(value.isEmpty) {
                      return "Email is required";
                    }
                    else if(isEmailValid != true) {
                      return "Email is not valid";
                    }
                    else {
                      return null;
                    }
                  },
                ),
              ),

              // for phone

              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_LARGE),
                child: CustomTextField(
                  hintText: "Enter your username",
                  focusNode: _userNameFocus,
                  nextNode: _passwordFocus,
                  controller: _userNameController,
                  doValidate: (input){
                    if(input.isEmpty)
                      return "Username required";
                    return null;
                  },
                  //isPhoneNumber: true,
                ),
              ),

              // for password
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_LARGE),
                child: CustomPasswordTextField(
                  hintTxt: Strings.PASSWORD,
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  nextNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.next,
                ),
              ),

              // for re-enter password
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_LARGE),
                child: CustomPasswordTextField(
                  hintTxt: Strings.RE_ENTER_PASSWORD,
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        ),

        // for register button
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
          child: CustomButton(onTap: addUser, buttonText: Strings.SIGN_UP),
        ),

        /* // for skip for now
        Center(
            child: FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AuthScreen()));
          },
          child: Text(Strings.SKIP_FOR_NOW,
              style: titilliumRegular.copyWith(
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                  color: ColorResources.COLUMBIA_BLUE)),
        )),*/
      ],
    );
  }
}
