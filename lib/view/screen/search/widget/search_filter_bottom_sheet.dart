import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/search_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';

class SearchFilterBottomSheet extends StatefulWidget {
  @override
  _SearchFilterBottomSheetState createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  final TextEditingController _firstPriceController = TextEditingController();
  final TextEditingController _lastPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            Expanded(
                child: Text(Strings.sort_and_filters, style: titilliumBold)),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.cancel, color: ColorResources.RED),
            )
          ]),
          Divider(),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          Consumer<SearchProvider>(
            builder: (context, search, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 35,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(Strings.PRICE_RANGE,
                              style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_SMALL))),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          controller: _firstPriceController,
                          style: titilliumBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorResources.colorMap[100],
                            contentPadding:
                                EdgeInsets.only(left: 5.0, bottom: 17),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.7),
                            ),
                          ),
                        ),
                      ),
                      Text(' - '),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: _lastPriceController,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          style: titilliumBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorResources.colorMap[100],
                            contentPadding:
                                EdgeInsets.only(left: 5.0, bottom: 17),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                Text(
                  Strings.SORT_BY,
                  style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL,
                      color: ColorResources.HINT_TEXT_COLOR),
                ),
                MyCheckBox(title: Strings.latest_products, index: 0),
                Row(children: [
                  Expanded(
                      child: MyCheckBox(
                          title: Strings.alphabetically_az, index: 1)),
                  Expanded(
                      child: MyCheckBox(
                          title: Strings.alphabetically_za, index: 2)),
                ]),
                Row(children: [
                  Expanded(
                      child: MyCheckBox(
                          title: Strings.low_to_high_price, index: 3)),
                  Expanded(
                      child: MyCheckBox(
                          title: Strings.high_to_low_price, index: 4)),
                ]),
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: CustomButton(
                    buttonText: Strings.APPLY,
                    onTap: () {
                      double minPrice = 0.0;
                      double maxPrice = 0.0;
                      if (_firstPriceController.text.isNotEmpty &&
                          _lastPriceController.text.isNotEmpty) {
                        minPrice = double.parse(_firstPriceController.text);
                        maxPrice = double.parse(_lastPriceController.text);
                      }
                      //Provider.of<SearchProvider>(context, listen: false).sortSearchList(minPrice, maxPrice);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class MyCheckBox extends StatelessWidget {
  final String title;
  final int index;
  MyCheckBox({@required this.title, @required this.index});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title,
          style:
              titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
      checkColor: ColorResources.COLOR_PRIMARY,
      activeColor: Colors.transparent,
      value: Provider.of<SearchProvider>(context).filterIndex == index,
      onChanged: (isChecked) {
        if (isChecked) {
          Provider.of<SearchProvider>(context, listen: false)
              .setFilterIndex(index);
        }
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
