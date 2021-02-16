import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';

class CartWidget extends StatelessWidget {
  final CartModel cartModel;
  final int index;
  final bool fromCheckout;
  const CartWidget(
      {Key key,
      this.cartModel,
      @required this.index,
      @required this.fromCheckout});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(color: ColorResources.WHITE),
      child: Column(
        children: [
          Row(children: [
            /* !fromCheckout
                ? InkWell(
                    onTap: () =>
                        Provider.of<CartProvider>(context, listen: false)
                            .toggleSelected(index),
                    child: Container(
                      width: 15,
                      height: 15,
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: ColorResources.COLOR_PRIMARY, width: 1),
                      ),
                      child: Provider.of<CartProvider>(context)
                              .isSelectedList[index]
                          ? Icon(Icons.done,
                              color: ColorResources.COLOR_PRIMARY,
                              size: Dimensions.ICON_SIZE_EXTRA_SMALL)
                          : SizedBox.shrink(),
                    ),
                  )
                : SizedBox.shrink(),*/
            /* Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Image.network(
                cartModel.image,
                height: 50,
                width: 50,
              ),
            ),*/
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${cartModel.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: titilliumBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                          color: ColorResources.HINT_TEXT_COLOR,
                        )),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${cartModel.priceSymbol} ${cartModel.price}", //PriceConverter.convertPrice(context, cartModel.price),
                          style: titilliumSemiBold.copyWith(
                              color: ColorResources.COLOR_PRIMARY),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "x${cartModel.quantity} QTY", //PriceConverter.convertPrice(context, cartModel.price),
                          style:
                              titilliumSemiBold.copyWith(color: Colors.black54),
                        ),
                        Spacer(),

                        /* Container(
                          width: 50,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: ColorResources.COLOR_PRIMARY),
                          ),
                          child: Text('${48}% OFF',
                              textAlign: TextAlign.center,
                              style: titilliumRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                color: ColorResources.HINT_TEXT_COLOR,
                              )),
                        ),*/
                      ],
                    ),
                    !fromCheckout
                        ? Row(
                            children: [
                              /*  QuantityButton(
                                  isIncrement: false,
                                  index: index,
                                  quantity: cartModel.quantity),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.PADDING_SIZE_SMALL),
                                child: Text(cartModel.quantity.toString(),
                                    style: titilliumSemiBold),
                              ),
                              QuantityButton(
                                  isIncrement: true,
                                  index: index,
                                  quantity: cartModel.quantity),*/
                            ],
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            !fromCheckout
                ? IconButton(
                    onPressed: () async {
                      Provider.of<CartProvider>(context, listen: false)
                          .isDeleting = true;
                      if (Provider.of<CartProvider>(context, listen: false)
                          .isDeleting) {
                        showCustomSnackBar(
                            "Please wait, deleting from cart", context);
                      }
                      await Provider.of<CartProvider>(context, listen: false)
                          .removeFromCart(index,
                              itemRemovingKey: cartModel.itemKey);

                      await Provider.of<CartProvider>(context, listen: false)
                          .initTotalCartCount();
                    },
                    icon: Icon(Icons.cancel, color: ColorResources.RED),
                  )
                : SizedBox.shrink(),
          ]),
          /*  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Variations: ", style: titilliumBold),
              for (dynamic i in cartModel.listOfVariation)
                Flexible(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text("${i} ", style: titilliumSemiBold)),
                ),
            ],
          )*/
        ],
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final int quantity;
  final int index;
  QuantityButton(
      {@required this.isIncrement,
      @required this.quantity,
      @required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isIncrement && quantity > 1) {
          Provider.of<CartProvider>(context, listen: false)
              .setQuantity(false, index);
        } else if (isIncrement) {
          Provider.of<CartProvider>(context, listen: false)
              .setQuantity(true, index);
        }
      },
      child: Icon(
        isIncrement ? Icons.add_circle : Icons.remove_circle,
        color: isIncrement
            ? ColorResources.COLOR_PRIMARY
            : 0 > 1
                ? ColorResources.COLOR_PRIMARY
                : ColorResources.IMAGE_BG,
        size: 15,
      ),
    );
  }
}
