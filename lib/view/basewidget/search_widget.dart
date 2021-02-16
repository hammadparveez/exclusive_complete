import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/search_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  final Function onTextChanged;
  final Function onClearPressed;
  final Function onSubmit;
  SearchWidget(
      {@required this.hintText,
      this.onTextChanged,
      @required this.onClearPressed,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(
        text: Provider.of<SearchProvider>(context).searchText);
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        child: Image.asset(Images.toolbar_background,
            fit: BoxFit.fill, height: 100, width: double.infinity),
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: 90 - MediaQuery.of(context).padding.top,
        alignment: Alignment.center,
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios,
                size: 20, color: ColorResources.WHITE),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius: BorderRadius.circular(8.0)),
              child: TextFormField(
                autofocus: true,
                controller: _controller,
                onFieldSubmitted: (query) {
                  onSubmit(query);
                },
                onChanged: (query) {
                  onTextChanged(query);
                },
                textInputAction: TextInputAction.search,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: robotoRegular.copyWith(
                      color: ColorResources.HINT_TEXT_COLOR),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search,
                      color: ColorResources.COLOR_PRIMARY,
                      size: Dimensions.ICON_SIZE_DEFAULT),
                  suffixIcon: Provider.of<SearchProvider>(context)
                          .searchText
                          .isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: ColorResources.GREY),
                          onPressed: () {
                            onClearPressed();
                            _controller.clear();
                          },
                        )
                      : _controller.text.isNotEmpty
                          ? IconButton(
                              icon:
                                  Icon(Icons.clear, color: ColorResources.GREY),
                              onPressed: () {
                                onClearPressed();
                                _controller.clear();
                              },
                            )
                          : null,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
        ]),
      ),
    ]);
  }
}
