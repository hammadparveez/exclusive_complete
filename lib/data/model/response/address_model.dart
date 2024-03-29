class AddressModel {
  int id;
  String customerId;
  String contactPersonName;
  String addressType;
  String address;
  String city;
  String zip;
  String phone;
  String createdAt;
  String updatedAt;
  List<CountryModel> countryModel;

  AddressModel(
      {this.id,
      this.customerId,
      this.contactPersonName,
      this.addressType,
      this.address,
      this.city,
      this.zip,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.countryModel});

  AddressModel.fromJson(Map<String, dynamic> json, {List<dynamic> countries}) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countryModel = countries;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['contact_person_name'] = this.contactPersonName;
    data['address_type'] = this.addressType;
    data['address'] = this.address;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CountryModel {
  int countryId, order;
  String name;
  CountryModel.fromJson(Map<String, dynamic> json) {
    countryId = json["id"];
    name = json["name"];
    order = json["order"];
  }
}

class CountryMethodModel {
  int methodId, instanceId, order;
  String title, method_title, cost;
  bool enabled;

  CountryMethodModel.fromJson(Map<String, dynamic> json) {
    methodId = json["id"];
    instanceId = json["instance_id"];
    title = json["title"];
    order = json["order"];
    enabled = json["enabled"];
    if (json["settings"] != null && json["settings"]["cost"] != null) {
      cost =
          json["settings"] != null ? json["settings"]["cost"]["value"] : null;
    }
  }
}
