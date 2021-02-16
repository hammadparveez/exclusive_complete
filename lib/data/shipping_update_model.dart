// To parse this JSON data, do
//
//     final ShippingUpdateModel = ShippingUpdateModelFromMap(jsonString);

import 'dart:convert';

class ShippingUpdateModel {
  ShippingUpdateModel({
    this.coupons,
    this.shippingRates,
    this.shippingAddress,
    this.items,
    this.itemsCount,
    this.itemsWeight,
    this.needsPayment,
    this.needsShipping,
    this.totals,
    this.errors,
  });

  List<dynamic> coupons;
  List<ShippingUpdateModelShippingRate> shippingRates;
  ShippingAddress shippingAddress;
  List<ShippingUpdateModelItem> items;
  int itemsCount;
  int itemsWeight;
  bool needsPayment;
  bool needsShipping;
  ShippingUpdateModelTotals totals;
  List<dynamic> errors;

  factory ShippingUpdateModel.fromJson(String str) =>
      ShippingUpdateModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingUpdateModel.fromMap(Map<String, dynamic> json) =>
      ShippingUpdateModel(
        coupons: json["coupons"] == null
            ? null
            : List<dynamic>.from(json["coupons"].map((x) => x)),
        shippingRates: json["shipping_rates"] == null
            ? null
            : List<ShippingUpdateModelShippingRate>.from(json["shipping_rates"]
                .map((x) => ShippingUpdateModelShippingRate.fromMap(x))),
        shippingAddress: json["shipping_address"] == null
            ? null
            : ShippingAddress.fromMap(json["shipping_address"]),
        items: json["items"] == null
            ? null
            : List<ShippingUpdateModelItem>.from(
                json["items"].map((x) => ShippingUpdateModelItem.fromMap(x))),
        itemsCount: json["items_count"] == null ? null : json["items_count"],
        itemsWeight: json["items_weight"] == null ? null : json["items_weight"],
        needsPayment:
            json["needs_payment"] == null ? null : json["needs_payment"],
        needsShipping:
            json["needs_shipping"] == null ? null : json["needs_shipping"],
        totals: json["totals"] == null
            ? null
            : ShippingUpdateModelTotals.fromMap(json["totals"]),
        errors: json["errors"] == null
            ? null
            : List<dynamic>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "coupons":
            coupons == null ? null : List<dynamic>.from(coupons.map((x) => x)),
        "shipping_rates": shippingRates == null
            ? null
            : List<dynamic>.from(shippingRates.map((x) => x.toMap())),
        "shipping_address":
            shippingAddress == null ? null : shippingAddress.toMap(),
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toMap())),
        "items_count": itemsCount == null ? null : itemsCount,
        "items_weight": itemsWeight == null ? null : itemsWeight,
        "needs_payment": needsPayment == null ? null : needsPayment,
        "needs_shipping": needsShipping == null ? null : needsShipping,
        "totals": totals == null ? null : totals.toMap(),
        "errors":
            errors == null ? null : List<dynamic>.from(errors.map((x) => x)),
      };
}

class ShippingUpdateModelItem {
  ShippingUpdateModelItem({
    this.key,
    this.id,
    this.quantity,
    this.quantityLimit,
    this.name,
    this.shortDescription,
    this.description,
    this.sku,
    this.lowStockRemaining,
    this.backordersAllowed,
    this.soldIndividually,
    this.permalink,
    this.images,
    this.variation,
    this.prices,
    this.totals,
  });

  String key;
  int id;
  int quantity;
  int quantityLimit;
  String name;
  String shortDescription;
  String description;
  String sku;
  dynamic lowStockRemaining;
  bool backordersAllowed;
  bool soldIndividually;
  String permalink;
  List<Image> images;
  List<Variation> variation;
  Prices prices;
  ItemTotals totals;

  factory ShippingUpdateModelItem.fromJson(String str) =>
      ShippingUpdateModelItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingUpdateModelItem.fromMap(Map<String, dynamic> json) =>
      ShippingUpdateModelItem(
        key: json["key"] == null ? null : json["key"],
        id: json["id"] == null ? null : json["id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        quantityLimit:
            json["quantity_limit"] == null ? null : json["quantity_limit"],
        name: json["name"] == null ? null : json["name"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
        description: json["description"] == null ? null : json["description"],
        sku: json["sku"] == null ? null : json["sku"],
        lowStockRemaining: json["low_stock_remaining"],
        backordersAllowed: json["backorders_allowed"] == null
            ? null
            : json["backorders_allowed"],
        soldIndividually: json["sold_individually"] == null
            ? null
            : json["sold_individually"],
        permalink: json["permalink"] == null ? null : json["permalink"],
        images: json["images"] == null
            ? null
            : List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
        variation: json["variation"] == null
            ? null
            : List<Variation>.from(
                json["variation"].map((x) => Variation.fromMap(x))),
        prices: json["prices"] == null ? null : Prices.fromMap(json["prices"]),
        totals:
            json["totals"] == null ? null : ItemTotals.fromMap(json["totals"]),
      );

  Map<String, dynamic> toMap() => {
        "key": key == null ? null : key,
        "id": id == null ? null : id,
        "quantity": quantity == null ? null : quantity,
        "quantity_limit": quantityLimit == null ? null : quantityLimit,
        "name": name == null ? null : name,
        "short_description": shortDescription == null ? null : shortDescription,
        "description": description == null ? null : description,
        "sku": sku == null ? null : sku,
        "low_stock_remaining": lowStockRemaining,
        "backorders_allowed":
            backordersAllowed == null ? null : backordersAllowed,
        "sold_individually": soldIndividually == null ? null : soldIndividually,
        "permalink": permalink == null ? null : permalink,
        "images": images == null
            ? null
            : List<dynamic>.from(images.map((x) => x.toMap())),
        "variation": variation == null
            ? null
            : List<dynamic>.from(variation.map((x) => x.toMap())),
        "prices": prices == null ? null : prices.toMap(),
        "totals": totals == null ? null : totals.toMap(),
      };
}

class Image {
  Image({
    this.id,
    this.src,
    this.thumbnail,
    this.srcset,
    this.sizes,
    this.name,
    this.alt,
  });

  int id;
  String src;
  String thumbnail;
  String srcset;
  String sizes;
  String name;
  String alt;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"] == null ? null : json["id"],
        src: json["src"] == null ? null : json["src"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        srcset: json["srcset"] == null ? null : json["srcset"],
        sizes: json["sizes"] == null ? null : json["sizes"],
        name: json["name"] == null ? null : json["name"],
        alt: json["alt"] == null ? null : json["alt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "src": src == null ? null : src,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "srcset": srcset == null ? null : srcset,
        "sizes": sizes == null ? null : sizes,
        "name": name == null ? null : name,
        "alt": alt == null ? null : alt,
      };
}

class Prices {
  Prices({
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.priceRange,
    this.rawPrices,
  });

  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyDecimalSeparator;
  String currencyThousandSeparator;
  String currencyPrefix;
  String currencySuffix;
  String price;
  String regularPrice;
  String salePrice;
  dynamic priceRange;
  RawPrices rawPrices;

  factory Prices.fromJson(String str) => Prices.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Prices.fromMap(Map<String, dynamic> json) => Prices(
        currencyCode:
            json["currency_code"] == null ? null : json["currency_code"],
        currencySymbol:
            json["currency_symbol"] == null ? null : json["currency_symbol"],
        currencyMinorUnit: json["currency_minor_unit"] == null
            ? null
            : json["currency_minor_unit"],
        currencyDecimalSeparator: json["currency_decimal_separator"] == null
            ? null
            : json["currency_decimal_separator"],
        currencyThousandSeparator: json["currency_thousand_separator"] == null
            ? null
            : json["currency_thousand_separator"],
        currencyPrefix:
            json["currency_prefix"] == null ? null : json["currency_prefix"],
        currencySuffix:
            json["currency_suffix"] == null ? null : json["currency_suffix"],
        price: json["price"] == null ? null : json["price"],
        regularPrice:
            json["regular_price"] == null ? null : json["regular_price"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
        priceRange: json["price_range"],
        rawPrices: json["raw_prices"] == null
            ? null
            : RawPrices.fromMap(json["raw_prices"]),
      );

  Map<String, dynamic> toMap() => {
        "currency_code": currencyCode == null ? null : currencyCode,
        "currency_symbol": currencySymbol == null ? null : currencySymbol,
        "currency_minor_unit":
            currencyMinorUnit == null ? null : currencyMinorUnit,
        "currency_decimal_separator":
            currencyDecimalSeparator == null ? null : currencyDecimalSeparator,
        "currency_thousand_separator": currencyThousandSeparator == null
            ? null
            : currencyThousandSeparator,
        "currency_prefix": currencyPrefix == null ? null : currencyPrefix,
        "currency_suffix": currencySuffix == null ? null : currencySuffix,
        "price": price == null ? null : price,
        "regular_price": regularPrice == null ? null : regularPrice,
        "sale_price": salePrice == null ? null : salePrice,
        "price_range": priceRange,
        "raw_prices": rawPrices == null ? null : rawPrices.toMap(),
      };
}

class RawPrices {
  RawPrices({
    this.precision,
    this.price,
    this.regularPrice,
    this.salePrice,
  });

  int precision;
  String price;
  String regularPrice;
  String salePrice;

  factory RawPrices.fromJson(String str) => RawPrices.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RawPrices.fromMap(Map<String, dynamic> json) => RawPrices(
        precision: json["precision"] == null ? null : json["precision"],
        price: json["price"] == null ? null : json["price"],
        regularPrice:
            json["regular_price"] == null ? null : json["regular_price"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
      );

  Map<String, dynamic> toMap() => {
        "precision": precision == null ? null : precision,
        "price": price == null ? null : price,
        "regular_price": regularPrice == null ? null : regularPrice,
        "sale_price": salePrice == null ? null : salePrice,
      };
}

class ItemTotals {
  ItemTotals({
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix,
    this.lineSubtotal,
    this.lineSubtotalTax,
    this.lineTotal,
    this.lineTotalTax,
  });

  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyDecimalSeparator;
  String currencyThousandSeparator;
  String currencyPrefix;
  String currencySuffix;
  String lineSubtotal;
  String lineSubtotalTax;
  String lineTotal;
  String lineTotalTax;

  factory ItemTotals.fromJson(String str) =>
      ItemTotals.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemTotals.fromMap(Map<String, dynamic> json) => ItemTotals(
        currencyCode:
            json["currency_code"] == null ? null : json["currency_code"],
        currencySymbol:
            json["currency_symbol"] == null ? null : json["currency_symbol"],
        currencyMinorUnit: json["currency_minor_unit"] == null
            ? null
            : json["currency_minor_unit"],
        currencyDecimalSeparator: json["currency_decimal_separator"] == null
            ? null
            : json["currency_decimal_separator"],
        currencyThousandSeparator: json["currency_thousand_separator"] == null
            ? null
            : json["currency_thousand_separator"],
        currencyPrefix:
            json["currency_prefix"] == null ? null : json["currency_prefix"],
        currencySuffix:
            json["currency_suffix"] == null ? null : json["currency_suffix"],
        lineSubtotal:
            json["line_subtotal"] == null ? null : json["line_subtotal"],
        lineSubtotalTax: json["line_subtotal_tax"] == null
            ? null
            : json["line_subtotal_tax"],
        lineTotal: json["line_total"] == null ? null : json["line_total"],
        lineTotalTax:
            json["line_total_tax"] == null ? null : json["line_total_tax"],
      );

  Map<String, dynamic> toMap() => {
        "currency_code": currencyCode == null ? null : currencyCode,
        "currency_symbol": currencySymbol == null ? null : currencySymbol,
        "currency_minor_unit":
            currencyMinorUnit == null ? null : currencyMinorUnit,
        "currency_decimal_separator":
            currencyDecimalSeparator == null ? null : currencyDecimalSeparator,
        "currency_thousand_separator": currencyThousandSeparator == null
            ? null
            : currencyThousandSeparator,
        "currency_prefix": currencyPrefix == null ? null : currencyPrefix,
        "currency_suffix": currencySuffix == null ? null : currencySuffix,
        "line_subtotal": lineSubtotal == null ? null : lineSubtotal,
        "line_subtotal_tax": lineSubtotalTax == null ? null : lineSubtotalTax,
        "line_total": lineTotal == null ? null : lineTotal,
        "line_total_tax": lineTotalTax == null ? null : lineTotalTax,
      };
}

class Variation {
  Variation({
    this.attribute,
    this.value,
  });

  String attribute;
  String value;

  factory Variation.fromJson(String str) => Variation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Variation.fromMap(Map<String, dynamic> json) => Variation(
        attribute: json["attribute"] == null ? null : json["attribute"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "attribute": attribute == null ? null : attribute,
        "value": value == null ? null : value,
      };
}

class ShippingAddress {
  ShippingAddress({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
  });

  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;

  factory ShippingAddress.fromJson(String str) =>
      ShippingAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingAddress.fromMap(Map<String, dynamic> json) => ShippingAddress(
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        company: json["company"] == null ? null : json["company"],
        address1: json["address_1"] == null ? null : json["address_1"],
        address2: json["address_2"] == null ? null : json["address_2"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        postcode: json["postcode"] == null ? null : json["postcode"],
        country: json["country"] == null ? null : json["country"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "company": company == null ? null : company,
        "address_1": address1 == null ? null : address1,
        "address_2": address2 == null ? null : address2,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "postcode": postcode == null ? null : postcode,
        "country": country == null ? null : country,
      };
}

class ShippingUpdateModelShippingRate {
  ShippingUpdateModelShippingRate({
    this.packageId,
    this.name,
    this.destination,
    this.items,
    this.shippingRates,
  });

  int packageId;
  String name;
  Destination destination;
  List<ShippingRateItem> items;
  List<ShippingRateShippingRate> shippingRates;

  factory ShippingUpdateModelShippingRate.fromJson(String str) =>
      ShippingUpdateModelShippingRate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingUpdateModelShippingRate.fromMap(Map<String, dynamic> json) =>
      ShippingUpdateModelShippingRate(
        packageId: json["package_id"] == null ? null : json["package_id"],
        name: json["name"] == null ? null : json["name"],
        destination: json["destination"] == null
            ? null
            : Destination.fromMap(json["destination"]),
        items: json["items"] == null
            ? null
            : List<ShippingRateItem>.from(
                json["items"].map((x) => ShippingRateItem.fromMap(x))),
        shippingRates: json["shipping_rates"] == null
            ? null
            : List<ShippingRateShippingRate>.from(json["shipping_rates"]
                .map((x) => ShippingRateShippingRate.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "package_id": packageId == null ? null : packageId,
        "name": name == null ? null : name,
        "destination": destination == null ? null : destination.toMap(),
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toMap())),
        "shipping_rates": shippingRates == null
            ? null
            : List<dynamic>.from(shippingRates.map((x) => x.toMap())),
      };
}

class Destination {
  Destination({
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
  });

  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;

  factory Destination.fromJson(String str) =>
      Destination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Destination.fromMap(Map<String, dynamic> json) => Destination(
        address1: json["address_1"] == null ? null : json["address_1"],
        address2: json["address_2"] == null ? null : json["address_2"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        postcode: json["postcode"] == null ? null : json["postcode"],
        country: json["country"] == null ? null : json["country"],
      );

  Map<String, dynamic> toMap() => {
        "address_1": address1 == null ? null : address1,
        "address_2": address2 == null ? null : address2,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "postcode": postcode == null ? null : postcode,
        "country": country == null ? null : country,
      };
}

class ShippingRateItem {
  ShippingRateItem({
    this.key,
    this.name,
    this.quantity,
  });

  String key;
  String name;
  int quantity;

  factory ShippingRateItem.fromJson(String str) =>
      ShippingRateItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingRateItem.fromMap(Map<String, dynamic> json) =>
      ShippingRateItem(
        key: json["key"] == null ? null : json["key"],
        name: json["name"] == null ? null : json["name"],
        quantity: json["quantity"] == null ? null : json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "key": key == null ? null : key,
        "name": name == null ? null : name,
        "quantity": quantity == null ? null : quantity,
      };
}

class ShippingRateShippingRate {
  ShippingRateShippingRate({
    this.rateId,
    this.name,
    this.description,
    this.deliveryTime,
    this.price,
    this.instanceId,
    this.methodId,
    this.metaData,
    this.selected,
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix,
  });

  String rateId;
  String name;
  String description;
  String deliveryTime;
  String price;
  int instanceId;
  String methodId;
  List<MetaDatum> metaData;
  bool selected;
  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyDecimalSeparator;
  String currencyThousandSeparator;
  String currencyPrefix;
  String currencySuffix;

  factory ShippingRateShippingRate.fromJson(String str) =>
      ShippingRateShippingRate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingRateShippingRate.fromMap(Map<String, dynamic> json) =>
      ShippingRateShippingRate(
        rateId: json["rate_id"] == null ? null : json["rate_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        deliveryTime:
            json["delivery_time"] == null ? null : json["delivery_time"],
        price: json["price"] == null ? null : json["price"],
        instanceId: json["instance_id"] == null ? null : json["instance_id"],
        methodId: json["method_id"] == null ? null : json["method_id"],
        metaData: json["meta_data"] == null
            ? null
            : List<MetaDatum>.from(
                json["meta_data"].map((x) => MetaDatum.fromMap(x))),
        selected: json["selected"] == null ? null : json["selected"],
        currencyCode:
            json["currency_code"] == null ? null : json["currency_code"],
        currencySymbol:
            json["currency_symbol"] == null ? null : json["currency_symbol"],
        currencyMinorUnit: json["currency_minor_unit"] == null
            ? null
            : json["currency_minor_unit"],
        currencyDecimalSeparator: json["currency_decimal_separator"] == null
            ? null
            : json["currency_decimal_separator"],
        currencyThousandSeparator: json["currency_thousand_separator"] == null
            ? null
            : json["currency_thousand_separator"],
        currencyPrefix:
            json["currency_prefix"] == null ? null : json["currency_prefix"],
        currencySuffix:
            json["currency_suffix"] == null ? null : json["currency_suffix"],
      );

  Map<String, dynamic> toMap() => {
        "rate_id": rateId == null ? null : rateId,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "delivery_time": deliveryTime == null ? null : deliveryTime,
        "price": price == null ? null : price,
        "instance_id": instanceId == null ? null : instanceId,
        "method_id": methodId == null ? null : methodId,
        "meta_data": metaData == null
            ? null
            : List<dynamic>.from(metaData.map((x) => x.toMap())),
        "selected": selected == null ? null : selected,
        "currency_code": currencyCode == null ? null : currencyCode,
        "currency_symbol": currencySymbol == null ? null : currencySymbol,
        "currency_minor_unit":
            currencyMinorUnit == null ? null : currencyMinorUnit,
        "currency_decimal_separator":
            currencyDecimalSeparator == null ? null : currencyDecimalSeparator,
        "currency_thousand_separator": currencyThousandSeparator == null
            ? null
            : currencyThousandSeparator,
        "currency_prefix": currencyPrefix == null ? null : currencyPrefix,
        "currency_suffix": currencySuffix == null ? null : currencySuffix,
      };
}

class MetaDatum {
  MetaDatum({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory MetaDatum.fromJson(String str) => MetaDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MetaDatum.fromMap(Map<String, dynamic> json) => MetaDatum(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
      };
}

class ShippingUpdateModelTotals {
  ShippingUpdateModelTotals({
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix,
    this.totalItems,
    this.totalItemsTax,
    this.totalFees,
    this.totalFeesTax,
    this.totalDiscount,
    this.totalDiscountTax,
    this.totalShipping,
    this.totalShippingTax,
    this.totalPrice,
    this.totalTax,
    this.taxLines,
  });

  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyDecimalSeparator;
  String currencyThousandSeparator;
  String currencyPrefix;
  String currencySuffix;
  String totalItems;
  String totalItemsTax;
  String totalFees;
  String totalFeesTax;
  String totalDiscount;
  String totalDiscountTax;
  String totalShipping;
  String totalShippingTax;
  String totalPrice;
  String totalTax;
  List<dynamic> taxLines;

  factory ShippingUpdateModelTotals.fromJson(String str) =>
      ShippingUpdateModelTotals.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingUpdateModelTotals.fromMap(Map<String, dynamic> json) =>
      ShippingUpdateModelTotals(
        currencyCode:
            json["currency_code"] == null ? null : json["currency_code"],
        currencySymbol:
            json["currency_symbol"] == null ? null : json["currency_symbol"],
        currencyMinorUnit: json["currency_minor_unit"] == null
            ? null
            : json["currency_minor_unit"],
        currencyDecimalSeparator: json["currency_decimal_separator"] == null
            ? null
            : json["currency_decimal_separator"],
        currencyThousandSeparator: json["currency_thousand_separator"] == null
            ? null
            : json["currency_thousand_separator"],
        currencyPrefix:
            json["currency_prefix"] == null ? null : json["currency_prefix"],
        currencySuffix:
            json["currency_suffix"] == null ? null : json["currency_suffix"],
        totalItems: json["total_items"] == null ? null : json["total_items"],
        totalItemsTax:
            json["total_items_tax"] == null ? null : json["total_items_tax"],
        totalFees: json["total_fees"] == null ? null : json["total_fees"],
        totalFeesTax:
            json["total_fees_tax"] == null ? null : json["total_fees_tax"],
        totalDiscount:
            json["total_discount"] == null ? null : json["total_discount"],
        totalDiscountTax: json["total_discount_tax"] == null
            ? null
            : json["total_discount_tax"],
        totalShipping:
            json["total_shipping"] == null ? null : json["total_shipping"],
        totalShippingTax: json["total_shipping_tax"] == null
            ? null
            : json["total_shipping_tax"],
        totalPrice: json["total_price"] == null ? null : json["total_price"],
        totalTax: json["total_tax"] == null ? null : json["total_tax"],
        taxLines: json["tax_lines"] == null
            ? null
            : List<dynamic>.from(json["tax_lines"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "currency_code": currencyCode == null ? null : currencyCode,
        "currency_symbol": currencySymbol == null ? null : currencySymbol,
        "currency_minor_unit":
            currencyMinorUnit == null ? null : currencyMinorUnit,
        "currency_decimal_separator":
            currencyDecimalSeparator == null ? null : currencyDecimalSeparator,
        "currency_thousand_separator": currencyThousandSeparator == null
            ? null
            : currencyThousandSeparator,
        "currency_prefix": currencyPrefix == null ? null : currencyPrefix,
        "currency_suffix": currencySuffix == null ? null : currencySuffix,
        "total_items": totalItems == null ? null : totalItems,
        "total_items_tax": totalItemsTax == null ? null : totalItemsTax,
        "total_fees": totalFees == null ? null : totalFees,
        "total_fees_tax": totalFeesTax == null ? null : totalFeesTax,
        "total_discount": totalDiscount == null ? null : totalDiscount,
        "total_discount_tax":
            totalDiscountTax == null ? null : totalDiscountTax,
        "total_shipping": totalShipping == null ? null : totalShipping,
        "total_shipping_tax":
            totalShippingTax == null ? null : totalShippingTax,
        "total_price": totalPrice == null ? null : totalPrice,
        "total_tax": totalTax == null ? null : totalTax,
        "tax_lines": taxLines == null
            ? null
            : List<dynamic>.from(taxLines.map((x) => x)),
      };
}
