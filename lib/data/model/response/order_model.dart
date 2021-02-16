import 'package:sixvalley_ui_kit/data/model/response/wordpress_customer_model.dart';

class OrderModel {
  int _id;
  String _shipping_total;

  String get shipping_total => _shipping_total;
  String _shipping_tax;
  String _cart_tax;
  String _order_key;
  String _transaction_id;
  String _customerId;
  String _customerType;
  String _paymentStatus;
  String _orderStatus;
  String _paymentMethod;
  String _transactionRef;
  String _orderAmount;
  String _shippingAddress;
  String _createdAt;
  String _updatedAt;
  String _discountAmount;
  String _discountType;
  String _payment_method_title;
  String _currency;
  String _currency_symbol;
  String _total;

  String get total => _total;
  List<LineItems> _listOfLineItems = [];
  String get order_key => _order_key;
  String _customer_ip_address, _customer_user_agent;
  List<ShippingLines> _shipping = [];
  BillingAddressModel _billing;
  String get payment_method_title => _payment_method_title;
  OrderModel(
      {int id,
      List<LineItems> listOfLineItems,
      String total,
      String currency,
      String customerId,
      String customerType,
      String paymentStatus,
      String orderStatus,
      String paymentMethod,
      String transactionRef,
      String orderAmount,
      String transaction_id,
      String payment_method_title,
      String shippingAddress,
      String createdAt,
      String updatedAt,
      String discountAmount,
      String discountType,
      BillingAddressModel billing,
      String currency_symbol,
      String shipping_total,
      String shipping_tax,
      String cart_tax,
      List<ShippingLines> shipping,
      String order_key,
      String customer_ip_address,
      String customer_user_agent}) {
    this._id = id;
    this._total = total;
    this._shipping = shipping;
    this._billing = billing;
    this._payment_method_title = payment_method_title;
    this._transaction_id = transaction_id;
    this._customer_ip_address = customer_ip_address;
    this._customer_user_agent = customer_user_agent;
    this._customerId = customerId;
    this._customerType = customerType;
    this._paymentStatus = paymentStatus;
    this._orderStatus = orderStatus;
    this._paymentMethod = paymentMethod;
    this._currency = currency;
    this._transactionRef = transactionRef;
    this._orderAmount = orderAmount;
    this._shippingAddress = shippingAddress;
    this._createdAt = createdAt;
    this._currency_symbol = currency_symbol;
    this._updatedAt = updatedAt;
    this._discountAmount = discountAmount;
    this._discountType = discountType;
    this._order_key = order_key;
    this._listOfLineItems = listOfLineItems;
  }

  List<LineItems> get listOfLineItems => _listOfLineItems;

  int get id => _id;
  String get customerId => _customerId;
  String get customerType => _customerType;
  String get paymentStatus => _paymentStatus;
  String get orderStatus => _orderStatus;
  String get paymentMethod => _paymentMethod;
  String get transactionRef => _transactionRef;
  String get orderAmount => _orderAmount;
  String get shippingAddress => _shippingAddress;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get discountAmount => _discountAmount;
  String get discountType => _discountType;
  String get currency_symbol => _currency_symbol;

  OrderModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _customerId = json['customer_id'].toString();
    _customerType = json['customer_type'];
    _customerType = json['customer_ip_address'];
    _paymentStatus = json['payment_status'];
    _orderStatus = json['status'];
    _paymentMethod = json['payment_method'];
    _transactionRef = json['transaction_ref'];
    _orderAmount = json['order_amount'];
    _shippingAddress = json['shipping_address'];
    _createdAt = json['date_created'];
    _updatedAt = json['updated_at'];
    _discountAmount = json['discount_total'];
    _discountType = json['discount_type'];
    _payment_method_title = json["payment_method_title"];
    _currency_symbol = json["currency_symbol"];
    _total = json["total"] ?? 0;
    _currency = json["currency"];
    _shipping_total = json["shipping_total"];
    _shipping_tax = json["shipping_tax"];
    _cart_tax = json["cart_tax"];
    if (json["billing"] != null) {
      _billing = BillingAddressModel.fromJson(json["billing"]);
    }
    _customer_ip_address = json["customer_ip_address"];
    _customer_user_agent = json["customer_user_agent"];
    _transaction_id = json["transaction_id"];
    if (json["shipping_lines"] != null) {
      final data = json["shipping_lines"] as List;
      data.forEach((shippingItem) {
        _shipping.add(ShippingLines.fromJson(shippingItem));
      });
    }
    if (json["line_items"] != null) {
      final lineItems = json["line_items"] as List;
      lineItems.forEach((item) {
        _listOfLineItems.add(LineItems.fromJson(item));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['customer_id'] = this._customerId;
    data['customer_type'] = this._customerType;
    data['payment_status'] = this._paymentStatus;
    data['order_status'] = this._orderStatus;
    data['payment_method'] = this._paymentMethod;
    data['transaction_ref'] = this._transactionRef;
    data['order_amount'] = this._orderAmount;
    data['shipping_address'] = this._shippingAddress;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['discount_amount'] = this._discountAmount;
    data['discount_type'] = this._discountType;
    return data;
  }

  String get customer_ip_address => _customer_ip_address;

  get customer_user_agent => _customer_user_agent;

  BillingAddressModel get billing => _billing;

  List<ShippingLines> get shipping => _shipping;

  String get transaction_id => _transaction_id;

  String get currency => _currency;

  String get shipping_tax => _shipping_tax;

  String get cart_tax => _cart_tax;
}

class LineItems {
  int id, product_id, variation_id, quantity;

  String name, tax_class, subtotal, subtotal_tax, total, total_tax;
  String taxes;
  List<dynamic> meta_data;

  LineItems(
      {this.id,
      this.product_id,
      this.variation_id,
      this.quantity,
      this.name,
      this.tax_class,
      this.subtotal,
      this.subtotal_tax,
      this.total,
      this.total_tax,
      this.taxes,
      this.meta_data});

  LineItems.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    product_id = json["product_id"];
    variation_id = json["variation_id"];
    quantity = json["quantity"];
    tax_class = json["tax_class"];
    subtotal = json["subtotal"];
    subtotal_tax = json["subtotal_tax"];
    total = json["total"];
    taxes = json["total_tax"];
    total_tax = json["total_tax"];
    total_tax = json["total_tax"];
    total_tax = json["total_tax"];
    meta_data = json["meta_data"];
  }
}

class ShippingLines {
  int id;
  String method_title, method_id, instance_id, total, total_tax, taxes;
  List<ShippingMetaData> meta_data = [];

  ShippingLines.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    method_title = json["method_title"];
    method_id = json["method_id"];
    instance_id = json["instance_id"];
    total = json["total"];
    total_tax = json["total_tax"];
    taxes = json["taxes"].toString();
    print("${json["shipping_lines"]}");
    if (json["meta_data"] != null) {
      final data = json["meta_data"] as List;
      data.forEach((metaData) {
        print("Meta DAta From ${metaData}");
        if (metaData["value"] is String)
          meta_data.add(ShippingMetaData.fromJson(metaData));
      });
    }
  }
}

class ShippingMetaData {
  int id;
  String key, value;

  ShippingMetaData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    key = json["key"];
    value = json["value"];
  }
}
