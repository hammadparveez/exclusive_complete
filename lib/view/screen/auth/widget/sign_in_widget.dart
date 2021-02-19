import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/body/login_model.dart';
import 'package:sixvalley_ui_kit/data/model/redirect_check.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/customer_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_textfield.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';

class SignInWidget extends StatefulWidget {
  final RedirectionCheck redirect;

  const SignInWidget({Key key, this.redirect}) : super(key: key);
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  TextEditingController _emailController;

  TextEditingController _passwordController;

  GlobalKey<FormState> _formKeyLogin;

  @override
  void initState() {
    super.initState();
    /*  GetIt.instance
        .get<SharedPreferences>()
        .clear()
        .then((value) => print("Cleared Everything"));*/
    _formKeyLogin = GlobalKey<FormState>();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.text =
        Provider.of<AuthProvider>(context, listen: false).getUserEmail() ??
            null;
    _passwordController.text =
        Provider.of<AuthProvider>(context, listen: false).getUserPassword() ??
            null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();
  LoginModel loginBody = LoginModel();

  void loginUser() async {
    if (_formKeyLogin.currentState.validate()) {
      _formKeyLogin.currentState.save();

      if (_emailController.text.isEmpty) {
        showCustomSnackBar(Strings.EMAIL_MUST_BE_REQUIRED, context);
      } else if (_passwordController.text.isEmpty) {
        showCustomSnackBar(Strings.PASSWORD_MUST_BE_REQUIRED, context);
      } else {
        loginBody.email = _emailController.text;
        loginBody.password = _passwordController.text;
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return AlertDialog(
                  content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Text("Please wait! Signing in... ", style: titilliumRegular),
                ],
              ));
            });
        //try {
        final userModel = await authProvider.login(loginBody);
        if (userModel != null) {
          Provider.of<ProfileProvider>(context, listen: false)
              .assignEmptyAddressList();
          /*Provider.of<ProfileProvider>(context, listen: false)
              .isAddressLoading = true;
          */
          /*final wordPressModel =
              await Provider.of<CustomerProvider>(context, listen: false)
                  .initCustomerDetails(userModel.id);*/
          Provider.of<CustomerProvider>(context, listen: false)
              .isFindingCustomer = true;
          final profileProvider =
              Provider.of<ProfileProvider>(context, listen: false);
          profileProvider.fetchRegion().then((value) {
            String foundValue = "";
            try {
              print("Mason }");
              foundValue = profileProvider.countryModel.keys.firstWhere(
                      (element) =>
                  profileProvider.countryModel[element] ==
                      profileProvider.addressList.first.country);
              print("Found Value ${foundValue}");
              Provider.of<ProfileProvider>(context, listen: false)
                  .updateShipping(countryCode: foundValue);
            } catch (error) {
              print("Nothing found in the country loop");
            }
            });

          print("Mason ${profileProvider.addressList.length}");

            //showCustomSnackBar("Something went wrong or Invalid credentials", context);
            print('Redirection check ${widget.redirect}');
            if (widget.redirect == RedirectionCheck.isCheckout) {
              Navigator.of(context).pop(context);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => DashBoardScreen(),
                  ),
                  (_) => false);
            }
          } else {
          Navigator.pop(context);
          showCustomSnackBar("Username/Password is incorrect.", context);
        }


        /*} catch (e) {
          print("${e}");
          //Navigator.pop(context);
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context),
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

          //
        }*/
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isRemember;
    //_emailController.text = 'demo@demo.com';
    //_passwordController.text = '123456';

    return Form(
      key: _formKeyLogin,
      child: ListView(
        children: [
          // for Email
          Container(
              margin: EdgeInsets.only(
                  left: Dimensions.MARGIN_SIZE_LARGE,
                  right: Dimensions.MARGIN_SIZE_LARGE,
                  bottom: Dimensions.MARGIN_SIZE_DEFAULT),
              child: CustomTextField(
                hintText: Strings.ENTER_YOUR_EMAIL,
                focusNode: _emailNode,
                nextNode: _passNode,
                isValidator: true,
                validatorMessage: Strings.PLEASE_PROVIDE_A_VALID_EMAIL,
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              )),

          // for Password
          Container(
              margin: EdgeInsets.only(
                  left: Dimensions.MARGIN_SIZE_LARGE,
                  right: Dimensions.MARGIN_SIZE_LARGE,
                  bottom: Dimensions.MARGIN_SIZE_DEFAULT),
              child: CustomPasswordTextField(
                hintTxt: Strings.ENTER_YOUR_PASSWORD,
                textInputAction: TextInputAction.done,
                focusNode: _passNode,
                controller: _passwordController,
              )),

          /*         // for remember and forgetpassword
          Container(
            margin: EdgeInsets.only(
                left: Dimensions.MARGIN_SIZE_SMALL,
                right: Dimensions.MARGIN_SIZE_LARGE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) => Checkbox(
                        checkColor: ColorResources.WHITE,
                        activeColor: ColorResources.COLOR_PRIMARY,
                        value: authProvider.isRemember,
                        onChanged: authProvider.updateRemember,
                      ),
                    ),
                    //

                    Text(Strings.REMEMBER, style: titilliumRegular),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ForgetPasswordScreen())),
                  child: Text(Strings.FORGET_PASSWORD,
                      style: titilliumRegular.copyWith(
                          color: ColorResources.PRIMARY_COLOR)),
                ),
              ],
            ),
          ),*/

          // for signin button
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
            child: CustomButton(onTap: loginUser, buttonText: Strings.SIGN_IN),
          ),

          // for sign in with google and facebook
          /*   Center(
              child: Text(Strings.OR_SIGN_IN_WITH,
                  style: titilliumRegular.copyWith(fontSize: 12))),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 37,
                height: 37,
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResources.WHITE,
                  border: Border.all(color: ColorResources.COLUMBIA_BLUE),
                ),
                child: GestureDetector(
                    onTap: () {}, child: Image.asset(Images.google)),
              ),
              Container(
                width: 37,
                height: 37,
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResources.WHITE,
                  border: Border.all(color: ColorResources.COLUMBIA_BLUE),
                ),
                child: Image.asset(Images.facebook),
              ),
            ],
          ),*/

          //for order as guest
          /*GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => DashBoardScreen()));
            },
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: 50),
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border:
                    Border.all(color: ColorResources.colorMap[100], width: 1.0),
              ),
              child: Text(Strings.ORDER_AS_GUEST,
                  style: titilliumSemiBold.copyWith(
                      color: ColorResources.colorMap[500])),
            ),
          ),*/
        ],
      ),
    );
  }
}
