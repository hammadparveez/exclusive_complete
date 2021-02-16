import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';

class CartModel {
  int id;
  String image;
  String name;
  String seller;
  double price;
  int quantity;
  String variant;
  String variation;
  double discount;
  String discountType;
  double tax;
  int shippingMethodId;
  String priceSymbol;
  String itemKey;
  List<String> listOfVariation = [];
  List<Map<String, dynamic>> itemVariations = [];
  List<WordPressProductVariations> wordpressVariations;
  int total_sales;
  bool taxable, in_stock, on_sale, shipping_required;
  List<CartModelItems> cart_model_items = [];

  CartModel({
    this.itemKey,
    this.id,
    this.image,
    this.name,
    this.seller,
    this.price,
    this.quantity,
    this.variant,
    this.variation,
    this.discount,
    this.discountType,
    this.tax,
    this.shippingMethodId,
    this.listOfVariation,
    this.priceSymbol,
    this.wordpressVariations,
    this.on_sale,
    this.in_stock,
    this.taxable,
    this.shipping_required,
    this.total_sales,
    this.itemVariations,
    this.cart_model_items,
  });

  /* String get variant => _variant;
  String get variation => _variation;
  // ignore: unnecessary_getters_setters
  int get quantity => _quantity;
  // ignore: unnecessary_getters_setters
  set quantity(int value) {
    _quantity = value;
  }

  double get price => _price;
  String get name => _name;
  String get seller => _seller;
  String get image => _image;
  int get id => _id;
  double get discount => _discount;
  String get discountType => _discountType;
  double get tax => _tax;
  int get shippingMethodId => _shippingMethodId;
*/
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    seller = json['seller'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    variant = json['variant'];
    variation = json['variation'];
    discount = json['discount'];
    discountType = json['discount_type'];
    priceSymbol = json['prefix'];
    tax = json['tax'];
    shippingMethodId = json['shipping_method_id'];
    on_sale = json["on_sale"];
    wordpressVariations = json["variations"];
    taxable = json["taxable"];
    total_sales = json["total_sales"];
    shipping_required = json["shipping_required"];
    if (json["items"] != null) {
      List items = json["items"];
      items.forEach((element) {
        print("Element adding ITems of cart ${element}");
        cart_model_items.add(CartModelItems.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['seller'] = this.seller;
    data['image'] = this.image;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['variant'] = this.variant;
    data['variation'] = this.variation;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['tax'] = this.tax;
    data['shipping_method_id'] = this.shippingMethodId;
    return data;
  }
}

// To parse this JSON data, do
//
//     final CartModelItems = CartModelItemsFromJson(jsonString);

class CartModelItems {
  CartModelItems({
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

  factory CartModelItems.fromJson(Map<String, dynamic> json) => CartModelItems(
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
      );

  Map<String, dynamic> toJson() => {
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
      };
}
