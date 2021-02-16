import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/title_row.dart';

class ProductSpecification extends StatelessWidget {
  final String productSpecification;
  ProductSpecification({@required this.productSpecification});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleRow(title: Strings.specification, isDetailsPage: true),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        Html(data: productSpecification),
        /* Text(
          productSpecification,
          style: titilliumRegular,
          textAlign: TextAlign.justify,
        ),*/
      ],
    );
  }
}
