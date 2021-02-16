// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class PaymentGateway {
  PaymentGateway({
    this.id,
    this.title,
    this.description,
    this.order,
    this.enabled,
    this.methodTitle,
    this.methodDescription,
    this.methodSupports,
    this.settings,
    this.links,
  });

  String id;
  String title;
  String description;
  int order;
  bool enabled;
  String methodTitle;
  String methodDescription;
  List<String> methodSupports;
  Settings settings;
  Links links;

  factory PaymentGateway.fromJson(String str) =>
      PaymentGateway.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentGateway.fromMap(Map<String, dynamic> json) => PaymentGateway(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        order: json["order"] == null ? null : json["order"],
        enabled: json["enabled"] == null ? null : json["enabled"],
        methodTitle: json["method_title"] == null ? null : json["method_title"],
        methodDescription: json["method_description"] == null
            ? null
            : json["method_description"],
        methodSupports: json["method_supports"] == null
            ? null
            : List<String>.from(json["method_supports"].map((x) => x)),
        settings: json["settings"] == null
            ? null
            : Settings.fromMap(json["settings"]),
        links: json["_links"] == null ? null : Links.fromMap(json["_links"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "order": order == null ? null : order,
        "enabled": enabled == null ? null : enabled,
        "method_title": methodTitle == null ? null : methodTitle,
        "method_description":
            methodDescription == null ? null : methodDescription,
        "method_supports": methodSupports == null
            ? null
            : List<dynamic>.from(methodSupports.map((x) => x)),
        "settings": settings == null ? null : settings.toMap(),
        "_links": links == null ? null : links.toMap(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection> self;
  List<Collection> collection;

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? null
            : List<Collection>.from(
                json["self"].map((x) => Collection.fromMap(x))),
        collection: json["collection"] == null
            ? null
            : List<Collection>.from(
                json["collection"].map((x) => Collection.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "self": self == null
            ? null
            : List<dynamic>.from(self.map((x) => x.toMap())),
        "collection": collection == null
            ? null
            : List<dynamic>.from(collection.map((x) => x.toMap())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String href;

  factory Collection.fromJson(String str) =>
      Collection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Collection.fromMap(Map<String, dynamic> json) => Collection(
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toMap() => {
        "href": href == null ? null : href,
      };
}

class Settings {
  Settings({
    this.title,
    this.instructions,
  });

  Instructions title;
  Instructions instructions;

  factory Settings.fromJson(String str) => Settings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Settings.fromMap(Map<String, dynamic> json) => Settings(
        title:
            json["title"] == null ? null : Instructions.fromMap(json["title"]),
        instructions: json["instructions"] == null
            ? null
            : Instructions.fromMap(json["instructions"]),
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title.toMap(),
        "instructions": instructions == null ? null : instructions.toMap(),
      };
}

class Instructions {
  Instructions({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.instructionsDefault,
    this.tip,
    this.placeholder,
  });

  String id;
  String label;
  String description;
  String type;
  String value;
  String instructionsDefault;
  String tip;
  String placeholder;

  factory Instructions.fromJson(String str) =>
      Instructions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Instructions.fromMap(Map<String, dynamic> json) => Instructions(
        id: json["id"] == null ? null : json["id"],
        label: json["label"] == null ? null : json["label"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"] == null ? null : json["type"],
        value: json["value"] == null ? null : json["value"],
        instructionsDefault: json["default"] == null ? null : json["default"],
        tip: json["tip"] == null ? null : json["tip"],
        placeholder: json["placeholder"] == null ? null : json["placeholder"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "label": label == null ? null : label,
        "description": description == null ? null : description,
        "type": type == null ? null : type,
        "value": value == null ? null : value,
        "default": instructionsDefault == null ? null : instructionsDefault,
        "tip": tip == null ? null : tip,
        "placeholder": placeholder == null ? null : placeholder,
      };
}
