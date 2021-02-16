class WpProductModel {
  final int id, reviewCount;
  final String name, short_desc, desc, price_html, avg_rating;
  final List images;
  WpProductModel({
    this.id,
    this.reviewCount,
    this.name,
    this.short_desc,
    this.desc,
    this.price_html,
    this.avg_rating,
    this.images,
  });
}
