class WordPressCustomerModel {
  BillingAddressModel billingAddressModel;
  ShippingAddressModel shippingAddressModel;
  int id, orders_count;
  String last_update,
      created_at,
      email,
      first_name,
      last_name,
      username,
      role,
      last_order_id,
      last_order_date,
      avatar_url,
      total_spent;

  WordPressCustomerModel.name(
      {this.billingAddressModel,
      this.shippingAddressModel,
      this.id,
      this.orders_count,
      this.total_spent,
      this.last_update,
      this.created_at,
      this.email,
      this.first_name,
      this.last_name,
      this.username,
      this.role,
      this.last_order_id,
      this.last_order_date,
      this.avatar_url});

  WordPressCustomerModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    first_name = json["first_name"];
    last_name = json["last_name"];
    last_order_id = json["last_order_id"].toString();
    last_order_date = json["last_order_date"];
    orders_count = json["orders_count"];
    total_spent = json["total_spent"];
    avatar_url = json["avatar_url"];

    if (json["billing_address"] != null) {
      billingAddressModel =
          BillingAddressModel.fromJson(json["billing_address"]);
    }
  }
}

class BillingAddressModel {
  String first_name,
      last_name,
      company,
      address_1,
      address_2,
      city,
      state,
      postcode,
      country,
      email,
      phone;

  BillingAddressModel(
      {this.first_name,
      this.last_name,
      this.company,
      this.address_1,
      this.address_2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.email,
      this.phone});

  BillingAddressModel.fromJson(Map<String, dynamic> json) {
    first_name = json["first_name"];
    last_name = json["last_name"];
    company = json["company"];
    address_1 = json["address_1"];
    address_2 = json["address_2"];
    city = json["city"];
    state = json["state"];
    postcode = json["postcode"];
    country = json["country"];
    email = json["email"];
    phone = json["phone"];
  }
}

class ShippingAddressModel {
  String first_name,
      last_name,
      company,
      address_1,
      address_2,
      city,
      state,
      postcode,
      country;

  ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    first_name = json["first_name"];
    last_name = json["last_name"];
    company = json["company"];
    address_1 = json["address_1"];
    address_2 = json["address_2"];
    city = json["city"];
    state = json["state"];
    postcode = json["postcode"];
    country = json["country"];
  }
}
