import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/provider/splash_provider.dart';

class PriceConverter {
  static int percentOff([String regularPrice = '0', String salePrice = '0']) {
    final off =
        0; //(double.parse(regularPrice) - double.parse(salePrice)) / 100;
    return off.toInt();
  }

  static String convertPrice(BuildContext context, double price,
      {String discount, String discountType}) {
    if (discount != null && discountType != null) {
      if (discountType == 'amount') {
        price = price - double.parse(discount);
      } else if (discountType == 'percent') {
        price = price - ((double.parse(discount) / 100) * price);
      }
    }
    return '${Provider.of<SplashProvider>(context, listen: false).currency.symbol}${price * double.parse(Provider.of<SplashProvider>(context, listen: false).currency.exchangeRate)}';
  }
}
