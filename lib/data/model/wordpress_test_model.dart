class WPModel {
  final int id, parent, reviewCount, count;
  final String permalink, shortDescription, description, name, slug;
  final PriceModel prices;
  final List<ImagesModel> images;
  final List<String> variations;
  final bool hasOptions, isPurchasable, isInStock, lowStockRemaining;

  WPModel({
    this.id,
    this.parent,
    this.reviewCount,
    this.count,
    this.permalink,
    this.shortDescription,
    this.description,
    this.name,
    this.slug,
    this.prices,
    this.images,
    this.variations,
    this.hasOptions,
    this.isPurchasable,
    this.isInStock,
    this.lowStockRemaining,
  });
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
  final int id;
  final String src, thumbnail, srcSet, sizes, name, alt;

  ImagesModel({
    this.id,
    this.src,
    this.thumbnail,
    this.srcSet,
    this.sizes,
    this.name,
    this.alt,
  });
}

class AddToCart {
  final String text, description;

  AddToCart({this.text, this.description});
}
