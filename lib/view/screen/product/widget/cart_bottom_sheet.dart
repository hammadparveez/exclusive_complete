import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider.dart';
import 'package:sixvalley_ui_kit/provider/variation_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/screen/checkout/checkout_screen.dart';

class CartBottomSheet extends StatefulWidget {
  final WordPressProductModel wordPressProductModel;
  final bool isIncrement;
  final Product product;
  final bool isBuy;
  final Function callback;
  final Function incCounter;
  final int counter;

  CartBottomSheet(
      {@required this.product,
      @required this.isBuy,
      @required this.callback,
      this.wordPressProductModel,
      this.counter,
      this.incCounter,
      this.isIncrement});

  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  List<String> selectedItem;
  int selectedKey;
  final Map<int, dynamic> menuItemData = {};
  String selectValue;
  List<int> doubleList;
  int optionItemIndex;
  List<bool> areItemsSelected = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < widget.wordPressProductModel.attributes.length; i++) {
      final List<int> items = [];
      for (int j = 0;
          j < widget.wordPressProductModel.attributes[i].options.length;
          j++) {
        final itemKey = Random().nextInt(100);
        menuItemData.addAll(
            {itemKey: widget.wordPressProductModel.attributes[i].options[j]});
        items.add(itemKey);
        print("${menuItemData[selectedKey]}");
      }
      final attributesLength = widget.wordPressProductModel.attributes.length;
      selectedItem = List(attributesLength);
      doubleList = List<int>.generate(attributesLength, (int index) => index);
      doubleList.forEach((index) {
        areItemsSelected.add(false);
        selectedItem[index] = null; //List(areItemsSelected.length);
      });

      //selectedItem.add(items);
    }
/*    selectedItem = List.generate(widget.wordPressProductModel.attributes.length,
        (index) => widget.wordPressProductModel.attributes[index].options);*/
  }

  List<Widget> dropDownBtn() {
    return doubleList.map<Widget>((e) {
      final item = widget.wordPressProductModel.attributes[e].options
          .asMap()
          .containsKey(optionItemIndex);
      print("checking the value of it ${item}");
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text("${widget.wordPressProductModel.attributes[e].name}",
                style: titilliumBold),
          ),
          DropdownButtonFormField(
              autovalidate: true,
              validator: (value) {
                print("Selected Value of an Item $value");
                if (value == null)
                  return "This item must be selected";
                else
                  return null;
                //return value;
              },
              items: dropDownMenuItems(e),
              //selectedItemBuilder: (_) {},
              hint: Text("Choose an option"),
              value: selectedItem[e],
              /* item
                  ? widget
                      .wordPressProductModel.attributes[e].options[optionItemIndex]
                  : null,*/
              onChanged: (value) {
                //if(widget.wordPressProductModel.attributes.length)

                onDropDownChange(e, value);
                print("Selected Value is : $value");
              }),
        ],
      );
    }).toList();
  }

  List<DropdownMenuItem> dropDownMenuItems(int index) {
    final List<DropdownMenuItem> items = [];
    widget.wordPressProductModel.attributes[index].options.forEach((element) {
      print("Element $element adn ${element.contains("Make to Measure")}");
      if (element != "Make to Measure")
        items.add(
          DropdownMenuItem(
            child: Text("$element"),
            value: element ?? Random().nextInt(1000),
            onTap: () {
              //optionItemIndex = i;
            },
          ),
        );
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    print("My Selected Product cheet id ${widget.wordPressProductModel.id}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      QuantityButton.quantity = 1;
      Provider.of<ProductDetailsProvider>(context, listen: false)
          .resetQuantity();
    });
    /*
    */
/*  String off = (double.parse(product.discount) /
            (double.parse(product.purchasePrice) * 100))
        .toStringAsFixed(1);*/ /*

    Variation _variation = Variation();
*/

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Color(0xff757575),
              child: Container(
                padding: EdgeInsets.only(top:Get.mediaQuery.padding.top+5, bottom: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL, left:Dimensions.PADDING_SIZE_SMALL,),
                decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Consumer<ProductDetailsProvider>(
                  builder: (context, details, child) {
                    int totalPrice = 0;
                    if(widget.wordPressProductModel.variations.isNotEmpty) {
                       totalPrice = int.parse(widget
                          .wordPressProductModel.variations.first.price) *
                          details.quantity;
                    }else {
                      totalPrice =  int.parse(widget
                          .wordPressProductModel.price) *
                          details.quantity;
                    }
                    /*double.parse(widget
                            .wordPressProductModel.variations.first.sale_price) **/
                    //details.quantity;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                          blurRadius: 10,
                                        )
                                      ]),
                                  child: Icon(Icons.clear,
                                      color: ColorResources.BLACK,
                                      size: Dimensions.ICON_SIZE_SMALL),
                                ),
                              )),

                          // Product details
                          Row(children: [
                            Container(
                              width: 100,
                              height: 100,
                              padding:
                                  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              decoration: BoxDecoration(
                                color: ColorResources.IMAGE_BG,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "${widget.wordPressProductModel?.images.first.src}" //product.thumbnail,
                                  ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /* Html(
                                        data: widget
                                            .wordPressProductModel.price_html)*/
                                    Text("${widget.wordPressProductModel.name}",
                                        style: titilliumRegular),
                                    Column(
                                      children: [
                                        if(widget.wordPressProductModel.variations.isEmpty)
                                          Row(children: [
                                            Text("${widget.wordPressProductModel.prefix} ${widget.wordPressProductModel.price}", style: titilliumSemiBold),
                                            const SizedBox(width:5),
                                            if(widget.wordPressProductModel.on_sale && widget.wordPressProductModel.regular_price != null && widget.wordPressProductModel.regular_price.isNotEmpty)
                                              Text("${widget.wordPressProductModel.prefix} ${widget.wordPressProductModel.regular_price}",style: const TextStyle(decoration: TextDecoration.lineThrough),),

                                          ],)
                                        else
                                          Row(
                                            children: [
                                              Text(
                                                  widget.wordPressProductModel.prefix != null &&
                                                      widget.wordPressProductModel
                                                          .variations.isNotEmpty
                                                      ? "${widget.wordPressProductModel.prefix} ${widget.wordPressProductModel.variations.first.price}"
                                                      : "",
                                                  style: titilliumSemiBold),
                                              widget.wordPressProductModel.prefix != null &&
                                                  widget.wordPressProductModel.variations.isNotEmpty
                                                  ? widget.wordPressProductModel.variations.first.on_sale
                                                  ? Text(
                                                " ${widget.wordPressProductModel.prefix} ${widget.wordPressProductModel.variations.first.regular_price}",
                                                style: TextStyle(
                                                    decoration:
                                                    TextDecoration.lineThrough,
                                                    color: Colors.black87),
                                              )
                                                  : SizedBox()
                                                  : SizedBox(),
                                            ],
                                          ),
                                      ],
                                    ),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: SizedBox.shrink()),
                                    /*  Text(
                                      "${widget.wordPressProductModel.price}",

                                      style: titilliumBold.copyWith(
                                          color: ColorResources.COLOR_PRIMARY,
                                          fontSize: 16),
                                    ),*/
                                    /*       Text(
                                      "${widget.wordPressProductModel.price}",
                                      */ /*PriceConverter.convertPrice(context, double.parse(product.unitPrice))*/ /*
                                      style: titilliumRegular.copyWith(
                                          color: ColorResources.HINT_TEXT_COLOR,
                                          decoration: TextDecoration.lineThrough),
                                    ),*/
                                    /*      Container(
                                      width: 50,
                                      height: 20,
                                      margin: EdgeInsets.only(
                                          top: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color:
                                                ColorResources.COLOR_PRIMARY),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text("",
                                          //"${PriceConverter.percentOff(widget.wordPressProductModel.variations.first.regular_price, widget.wordPressProductModel.variations.first.sale_price)}% OFF",
                                          style: titilliumRegular.copyWith(
                                            color:
                                                ColorResources.HINT_TEXT_COLOR,
                                            fontSize: 10,
                                          )),
                                    ),*/
                                  ]),
                            ),
                            Expanded(child: SizedBox.shrink()),
                            /* Text(
                                    double.parse(product.currentStock) > 0
                                        ? Strings.available
                                        : Strings.unavailable,
                                    style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                    )),*/
                          ]),

                          // Quantity
                          Row(children: [
                            Text(Strings.quantity, style: robotoBold),
                            QuantityButton(
                              isIncrement:
                                  false, //!wordPressProductModel.in_stock,
                              //quantity: 0,
                            ),
                            Text("${details.quantity}",
                                style: titilliumSemiBold),
                            QuantityButton(
                              isIncrement: true, /*quantity: details.quantity*/
                            ),
                          ]),
                          //Text("${wordPressProductModel.attributes.first.options}"),
                          // Variant
                          if (widget
                              .wordPressProductModel.attributes.isNotEmpty)

                            //for (dynamic i in attr.options)
                            /*   Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                    "${i} , ${attr.name}", //"${Strings.select_variant} ${wordPressProductModel.variants.keys.toList()[i]}",
                                                    style: robotoBold),
                                                SizedBox(
                                                  height: 25,
                                                  child: ListView.builder(
                                                    itemCount: 0,
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder: (context, index) {
                                                      String colorString =
                                                          '0xff00ff00'; //'0xff' + product.colors[index].code.substring(1, 7);
                                                      return InkWell(
                                                        onTap: () {
                                                          Provider.of<ProductDetailsProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .setCartVariantIndex(
                                                                  index);
                                                        },
                                                        child: Container(
                                                          height: 25,
                                                          width: 25,
                                                          margin: EdgeInsets.only(
                                                              left: Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            //color: Color(int.parse(colorString)),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    5),
                                                            border: Border.all(),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color:
                                                                      Colors.grey[200],
                                                                  spreadRadius: 3,
                                                                  blurRadius: 10)
                                                            ],
                                                          ),
                                                          child: Text("Test"
                                                              */ /*? Icon(Icons.done_all,
                                                                      color:
                                                                          ColorResources.WHITE,
                                                                      size: 12)
                                                                  : null,*/ /*
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(height: 8),
                                        ],
                                      ),*/
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          // Variation
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 0, // product.choiceOptions.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /*  Text(product.choiceOptions[index].title,
                                            style: robotoBold),*/
                                    SizedBox(
                                        height: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: (1 / 0.35),
                                      ),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: widget.product
                                          .choiceOptions[index].options.length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () {
                                            Provider.of<ProductDetailsProvider>(
                                                    context,
                                                    listen: false)
                                                .setCartVariationIndex(
                                                    index, i);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            decoration: BoxDecoration(
                                              color: details.variationIndex[
                                                          index] !=
                                                      i
                                                  ? ColorResources.WHITE
                                                  : ColorResources
                                                      .COLOR_PRIMARY,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: details.variationIndex[
                                                          index] !=
                                                      i
                                                  ? Border.all(
                                                      color: ColorResources
                                                          .HINT_TEXT_COLOR,
                                                      width: 2)
                                                  : null,
                                            ),
                                            child: Text(
                                                widget
                                                    .product
                                                    .choiceOptions[index]
                                                    .options[i],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    titilliumRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_SMALL,
                                                  color: details.variationIndex[
                                                              index] !=
                                                          i
                                                      ? ColorResources
                                                          .HINT_TEXT_COLOR
                                                      : ColorResources.WHITE,
                                                )),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                        height: Dimensions
                                            .PADDING_SIZE_EXTRA_LARGE),
                                  ]);
                            },
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                if(widget.wordPressProductModel.variations.isNotEmpty)
                          Column(
                            children: dropDownBtn(),
                          ),
                          /*DropdownButton(
                                  items: doubleList
                                      .map(
                                        (e) => DropdownMenuItem(
                                          child: Text("$e"),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {}),*/

                          /*  OptionsSelectorWidget(
                                wordPressProductModel: wordPressProductModel,
                              ),*/

                          Row(children: [
                            Text(Strings.total_price, style: robotoBold),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                            Text(
                              "${widget.wordPressProductModel.prefix} ${totalPrice /*widget.wordPressProductModel.price*/}",
                              //"${widget.wordPressProductModel.prefix} ${widget.wordPressProductModel.price}",
                              /*PriceConverter.convertPrice(context, price, discountType: product.discountType, discount: product.discount*/
                              style: titilliumBold.copyWith(
                                  color: ColorResources.COLOR_PRIMARY,
                                  fontSize: 16),
                            ),
                          ]),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          // Delivery Details
                          /*  Row(children: [
                                Text(Strings.delivery_charge, style: robotoBold),
                                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(
                                  "\$2.56",
                                  //PriceConverter.convertPrice(context, 3.56),
                                  style: titilliumSemiBold.copyWith(
                                      color: ColorResources.COLOR_PRIMARY,
                                      fontSize: Dimensions.FONT_SIZE_LARGE),
                                ),
                              ]),*/
                          Row(children: [
                            Image.asset(Images.fast_delivery,
                                color: ColorResources.BLACK,
                                width: 30,
                                height: 30),
                            SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            Text(Strings.fast_delivery_in,
                                style: titilliumRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_SMALL)),
                            SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            /*Text(Strings.one_day,
                                    style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL,
                                        color: ColorResources.COLOR_PRIMARY)),*/
                          ]),
                          Row(children: [
                            Image.asset(Images.delivery,
                                color: ColorResources.BLACK,
                                width: 30,
                                height: 30),
                            SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            Text(Strings.regular_delivery,
                                style: titilliumRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_SMALL)),
                            SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            Text(Strings.five_day,
                                style: titilliumRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_SMALL,
                                    color: ColorResources.COLOR_PRIMARY)),
                          ]),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Text(Strings.lorem,
                              textAlign: TextAlign.justify,
                              style: titilliumRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          // Cart button
                          0 == 0
                              ? Builder(
                                  builder: (ctx) => CustomButton(
                                      buttonText: widget.isBuy
                                          ? Strings.buy_now
                                          : Strings.add_to_cart,
                                      onTap: () async {
                                        List<Map<String, dynamic>> listOfSelectedAllItems = <Map<String, dynamic>>[];
                                        print("$selectValue");
                                        final selectedItems =
                                            areItemsSelected.where((element) {
                                          return element == true;
                                        }).toList();
                                        if(selectedItem != null) {
                                          if (selectedItems.length ==
                                              widget.wordPressProductModel
                                                  .attributes.length) {
                                            listOfSelectedAllItems =
                                            <Map<String, dynamic>>[];
                                            for (int j = 0;
                                            j < selectedItem.length;
                                            j++) {
                                              listOfSelectedAllItems.add({
                                                "attribute": widget
                                                    .wordPressProductModel
                                                    .attributes[j]
                                                    .name,
                                                "value": selectedItem[j]
                                              });
                                            }}

                                        print(listOfSelectedAllItems);
                           /*               if (widget.isBuy) {
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        CheckoutScreen(
                                                            cartList: [
                                                              _cartModel
                                                            ],
                                                            fromProductDetails:
                                                                true)));
                                          }*/
                                        }
                                        final _cartModel = CartModel(
                                          id: widget.wordPressProductModel.id,
                                          image: widget.wordPressProductModel
                                              .images.first.src,
                                          name: widget
                                              .wordPressProductModel.name,
                                          seller: "Exclusive Inn",
                                          price: totalPrice.toDouble(),
                                          quantity: details.quantity,
                                          variation: selectValue,
                                          itemVariations:
                                          listOfSelectedAllItems,
                                          listOfVariation: selectedItem,
                                          priceSymbol: widget
                                              .wordPressProductModel.prefix,
                                          on_sale: widget
                                              .wordPressProductModel.on_sale,
                                          in_stock: widget
                                              .wordPressProductModel.in_stock,
                                          wordpressVariations: widget
                                              .wordPressProductModel
                                              .variations,
                                          taxable: widget
                                              .wordPressProductModel.taxable,
                                          total_sales: widget
                                              .wordPressProductModel
                                              .total_sales,
                                        );
                                        if (_formKey.currentState
                                            .validate()) {
                                          print("Cart is Empty ");
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (_) {
                                                return WillPopScope(
                                                  onWillPop: () async =>
                                                  false,
                                                  child: AlertDialog(
                                                    content: Column(
                                                      mainAxisSize:
                                                      MainAxisSize.min,
                                                      children: [
                                                        CircularProgressIndicator(),
                                                        const SizedBox(
                                                            height: 8),
                                                        Text(
                                                            "Please wait..Adding to the cart")
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                          await Provider.of<CartProvider>(
                                              context,
                                              listen: false)
                                              .addToCart(_cartModel);
                                          Navigator.pop(context);
                                          if (!Provider.of<CartProvider>(
                                              context,
                                              listen: false)
                                              .isCartAdded) {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (_) {
                                                  return WillPopScope(
                                                    onWillPop: () async =>
                                                    false,
                                                    child: AlertDialog(
                                                      content: Text(
                                                          "We're sorry, Unable to add this item to the cart",
                                                          style: titilliumRegular
                                                              .copyWith(
                                                              fontSize:
                                                              Get.textScaleFactor *
                                                                  14)),
                                                      actions: [
                                                        FlatButton(
                                                          child:
                                                          Text("Close"),
                                                          onPressed: () =>
                                                              Get.back(),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          } else {
                                            Navigator.pop(context);
                                          }
                                          widget.callback();
                                        }
                                      }),
                                )
                              : SizedBox.shrink(),
                        ]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDropDownChange(dropDownIndex, value) {
    //optionItemIndex = ;
    print("Selected ITem Indexes ${selectedItem}");
    areItemsSelected[dropDownIndex] = true;
    selectedItem[dropDownIndex] = value;

    /*
    final item = widget.wordPressProductModel.attributes[dropDownIndex].options
        .indexWhere((element) {
      return element == value;
    });

    if (item != -1) {
      setState(() {

      });
    }*/

    //print("Index Value $item");

    print('onDropDownChange: $dropDownIndex -> $value');
  }

  List<DropdownMenuItem> listOfItems() {
    return widget.wordPressProductModel.attributes.first.options
        .map<DropdownMenuItem>((item) => DropdownMenuItem(
              child: Text("${item}"),
              value: item,
            ))
        .toList();
  }
}

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  static int quantity = 1;
  final bool isCartWidget;
  final int maxQuantity;

  QuantityButton({
    @required this.isIncrement,
    this.isCartWidget = false,
    @required this.maxQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (isIncrement) {
          Provider.of<ProductDetailsProvider>(context, listen: false)
              .setQuantity(++quantity);
        } else if (!isIncrement && quantity > 1 /*&& quantity < maxQuantity*/) {
          Provider.of<ProductDetailsProvider>(context, listen: false)
              .setQuantity(--quantity);
        }
      },
      icon: Icon(
        isIncrement ? Icons.add_circle : Icons.remove_circle,
        color: isIncrement
            ? ColorResources.COLOR_PRIMARY
            : quantity > 1
                ? ColorResources.COLOR_PRIMARY
                : ColorResources.IMAGE_BG,
        size: isCartWidget ? 26 : 20,
      ),
    );
  }
}

class OptionsSelectorWidget extends StatefulWidget {
  final WordPressProductModel wordPressProductModel;
  final Attributes attribute;
  final Function incCounter;
  final int counter;
  OptionsSelectorWidget({
    Key key,
    this.attribute,
    this.wordPressProductModel,
    this.incCounter,
    this.counter = 0,
  }) : super(key: key);

  @override
  _OptionsSelectorWidgetState createState() => _OptionsSelectorWidgetState();
}

class _OptionsSelectorWidgetState extends State<OptionsSelectorWidget> {
  final List<int> allItemsIndex = [];
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    int selectedIndex;
    return Consumer<VariationProvider>(
      builder: (_, variation, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int j = 0;
              j < widget.wordPressProductModel.attributes.length;
              j++) //for (Attributes attr in wordPressProductModel.attributes)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.wordPressProductModel.attributes[j].name}"),
                DropdownButton(
                  value: null, //selectedIndex,
                  items: [
                    for (int i = 0;
                        i <
                            widget.wordPressProductModel.attributes[j].options
                                .length;
                        i++)
                      DropdownMenuItem(
                        child: Text(
                            "${widget.wordPressProductModel.attributes[j].options[i]} and $counter"),
                        value: counter++,
                      )
                  ],
                  onChanged: (value) {
                    counter = value;
                    variation.setSelectedValue('value', index: counter);
                    print("Value changed from $selectedIndex ${counter}");
                  },
                  isExpanded: true,
                ),
              ],
            )
        ],
      ),
    );
  }
}
