class WordPressProductModel1 {
  int id, minQty, currentStock;
  double rating, price, discount, tax, realPrice;
  bool featured;
  String slug, categoryType, thumbnail, imgSrc, published, short_desc, title;
  List<String> sizes, moreImages, categories;
  List<String> relatedType;
  Map<String, List<String>> variants;
  WordPressProductModel1({
    this.featured,
    this.categories = const [],
    this.variants,
    this.relatedType,
    this.moreImages = const [],
    this.realPrice,
    this.id,
    this.minQty,
    this.currentStock,
    this.rating,
    this.price,
    this.discount,
    this.tax,
    this.slug,
    this.categoryType,
    this.thumbnail,
    this.imgSrc,
    this.published,
    this.short_desc,
    this.title,
    this.sizes,
  });
}

class WordPressProductModel {
  List<Attributes> attributes = [];
  List<dynamic> related_ids, categories, productVariations;
  List<WordPressProductVariations> variations = [];
  int id, parent, reviewCount, count, total_sales, rating_count, menu_order;
  List thumbnail_img;
  String permalink,
      regular_price,
      price,
      shortDescription,
      description,
      name,
      slug,
      prefix,
      createdAt,
      updated_at,
      sku,
      sale_price,
      price_html,
      stock_quantity,
      backorders_allowed,
      backordered,
      sold_individually,
      featured_src,
      average_rating;
  PricesModel prices;
  List<ImagesModel> images = [];
  bool hasOptions,
      on_sale,
      managing_stock,
      isPurchasable,
      in_stock,
      lowStockRemaining,
      featured,
      taxable;

  WordPressProductModel({
    this.related_ids,
    this.variations,
    this.id,
    this.parent,
    this.productVariations,
    this.reviewCount = 0,
    this.count,
    this.total_sales,
    this.permalink,
    this.categories,
    this.shortDescription,
    this.description,
    this.prefix,
    this.name,
    this.menu_order,
    this.slug,
    this.createdAt,
    this.updated_at,
    this.sku,
    this.sale_price,
    this.price_html,
    this.taxable,
    this.managing_stock,
    this.stock_quantity,
    this.in_stock,
    this.backorders_allowed,
    this.backordered,
    this.sold_individually,
    this.on_sale,
    this.featured_src,
    this.prices,
    this.images,
    this.hasOptions,
    this.isPurchasable,
    this.lowStockRemaining,
    this.average_rating,
    this.price,
    this.featured,
    this.rating_count,
    this.regular_price,
    this.attributes,
    this.thumbnail_img,
  });

  WordPressProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["title"] ?? json['name'];
    price_html = json["price_html"];
    prefix = json["prefix"];
    regular_price = json["regular_price"].toString();
    sale_price = json["sale_price"].toString();
    price = json["price"].toString();
    taxable = json["taxable"];
    managing_stock = json["managing_stock"];
    stock_quantity = json["stock_quantity"];
    in_stock = json["in_stock"];
    featured = json["featured"];
    on_sale = json["on_sale"];
    shortDescription = json["short_description"];
    description = json["description"];
    average_rating = json["average_rating"];
    related_ids = json["related_ids"];
    categories = json["categories"];
    featured_src = json["featured_src"].toString();
    total_sales = json["total_sales"];
    menu_order = json["menu_order"];
    thumbnail_img = json["thumbnail_img"] != false ? json["thumbnail_img"] : [];
    // count = json["count"];
    if (json["images"] != null) {
      final imgs = json["images"] as List;
      imgs.forEach((img) {
        images.add(ImagesModel.fromJson(img));
      });
    }
    if (json["variations"] != null && json["variations"].isNotEmpty) {
      json["variations"].forEach((variation) {
        print("XXXXXXXXX ${variation}");
        if (variation is Map<String, dynamic>)
          variations.add(WordPressProductVariations.fromJson(variation));
        else {
          variations.add(WordPressProductVariations(
              id: variation,
              price: sale_price,
              regular_price: regular_price,
              in_stock: in_stock,
              on_sale: on_sale,
              sale_price: sale_price));
        }
      });
    }
    if (json["attributes"] != null) {
      final listOfAttributes = json["attributes"] as List;
      listOfAttributes.forEach((attribute) {
        attributes.add(Attributes.fromJson(attribute));
      });
    }
  }
}

class PriceModel {
  final String currencyCode,
      currencySymbol,
      currencyMinorUnit,
      currencyDecimalSeparator,
      currencyThousandSeparator,
      currencyPrefix,
      currencySuffix,
      price,
      regularPrice,
      salePrice,
      priceRange;

  PriceModel({
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
  });
}

class ImagesModel {
  int id;
  String src, thumbnail, srcSet, sizes, name, alt;

  ImagesModel({
    this.id,
    this.src,
    this.thumbnail,
    this.srcSet,
    this.sizes,
    this.name,
    this.alt,
  });
  ImagesModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["src"] != null && json["src"].isNotEmpty)
      src = json["src"];
    else {
      src = "https://maheybook.com/images/no-image.jpg";
    }
    name = json["name"];
    //srcSet = json["srcset"];
    alt = json["alt"];
  }
// if (json["src"] != null) {
/*   final image = json["src"] as String;
      final lastIndex = image.lastIndexOf(".");
      final format = image.substring(lastIndex);
      final imageUrl = image.substring(0, lastIndex);

      final completeImage = imageUrl + "-200x300" + format;
      print(
          "Image URL IS $imageUrl and Format $format  Complete URL $completeImage");
      List imagesSrc = [];

      print("Thumbnail ${json["thumbnail"]} ");*/
}

class Categories {
  int id, parent, count;
  String name, slug, desc, display, image;

  Categories({
    this.id,
    this.parent,
    this.count,
    this.name,
    this.slug,
    this.desc,
    this.display,
    this.image,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    slug = json["slug"];
    parent = json["parent"];
    desc = json["description"];
    display = json["display"];
    image = json["image"];
    count = json["count"];
  }
}

class AddToCart {
  final String text, description;

  AddToCart({this.text, this.description});
}

class VariationDimension {
  final String length, width, height, unit;
  VariationDimension({this.length, this.width, this.height, this.unit});
}

class Attributes {
  List<dynamic> options;
  String name, slug;
  bool visible, variation;
  int position;

  Attributes(
      {this.options,
      this.name,
      this.slug,
      this.visible,
      this.variation,
      this.position});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    slug = json["slug"];
    position = json["position"];
    visible = json["visible"];
    variation = json["variation"];
    options = json["options"];
  }
}

class WordPressProductVariations {
  int id;
  String sku, price, regular_price, sale_price;
  bool in_stock, on_sale, stock_quantity;

  WordPressProductVariations({
    this.id,
    this.sku,
    this.price,
    this.regular_price,
    this.sale_price,
    this.in_stock,
    this.on_sale,
  });
  WordPressProductVariations.fromJson(Map<String, dynamic> json) {
    id = json["id"].runtimeType == int ? json["id"] : int.parse(json["id"]);
    sku = json["sku"];
    price = json["price"].toString();
    regular_price = json["regular_price"].toString();
    sale_price = json["sale_price"].toString();
    on_sale = json["on_sale"];
    in_stock = json["in_stock"];
    on_sale = json["on_sale"];
    stock_quantity = json["stock_quantity"];
  }
  //Attributes attributes;
}

class PricesModel {
  String currencyCode,
      currency_symbol,
      currency_decimal_separator,
      currency_thousand_separator,
      currency_prefix,
      currency_suffix,
      price,
      regular_price,
      sale_price,
      price_range;
  int currency_minor_unit;

  PricesModel.fromJson(Map<String, dynamic> json) {
    currency_symbol = json["currency_code"];
    currency_symbol = json["currency_symbol"];
    currency_minor_unit = json["currency_minor_unit"];
    currency_decimal_separator = json["currency_decimal_separator"];
    currency_thousand_separator = json["currency_thousand_separator"];
    currency_prefix = json["currency_prefix"];
    currency_suffix = json["currency_suffix"];
    price = json["price"];
    regular_price = json["regular_price"];
    regular_price = json["regular_price"];
    price_range = json["price_range"];
  }
}
