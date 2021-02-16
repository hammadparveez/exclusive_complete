import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/wishlist_provider.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_modal_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/screen/auth/auth_screen.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;
  final Color favColor;
  final bool isSelected;
  final Product product;
  final WordPressProductModel wordPressProductModel;
  FavouriteButton(
      {this.backgroundColor = Colors.black,
      this.favColor = Colors.white,
      this.isSelected = false,
      this.product,
      this.wordPressProductModel});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isGuestMode =
          !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    });

    feedbackMessage(String message) {
      if (message != '') {
        showCustomSnackBar(message, context, isError: false);
      }
    }

    return GestureDetector(
      onTap: () {
        if (isGuestMode) {
          showCustomModalDialog(
            context,
            title: Strings.THIS_SECTION_IS_LOCK,
            content: Strings.GOTO_LOGIN_SCREEN_ANDTRYAGAIN,
            cancelButtonText: Strings.CANCEL,
            submitButtonText: Strings.LOGIN,
            submitOnPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AuthScreen())),
            cancelOnPressed: () => Navigator.of(context).pop(),
          );
        } else {
          print("Wordpress ${wordPressProductModel}");
          Provider.of<WishListProvider>(context, listen: false).isWish
              ? Provider.of<WishListProvider>(context, listen: false)
                  .removeWishList(product,
                      feedbackMessage: feedbackMessage,
                      wordPressProductModel: wordPressProductModel)
              : Provider.of<WishListProvider>(context, listen: false)
                  .addWishList(product,
                      feedbackMessage: feedbackMessage,
                      wordPressProductModel: wordPressProductModel);
        }
      },
      child: Consumer<WishListProvider>(
        builder: (context, wishListProvider, child) => Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Image.asset(
              wishListProvider.isWish ? Images.wish_image : Images.wishlist,
              color: favColor,
              height: 30,
              width: 30,
            ),
          ),
        ),
      ),
    );
  }
}
