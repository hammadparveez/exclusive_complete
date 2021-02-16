class Category {
  int _id;

  get count => _count;
  String _name;
  String _slug;
  String _icon;
  String _parentId;
  String _position;
  String _createdAt;
  String _updatedAt;
  String _categoryName;
  String _count;
  List<SubCategory> _subCategories;

  Category(
      {int id,
      String categoryName,
      String name,
      String slug,
      String icon,
      String parentId,
      String position,
      String createdAt,
      String count,
      String updatedAt,
      List<SubCategory> subCategories}) {
    this._id = id;
    this._name = name;
    this._slug = slug;
    this._icon = icon;
    this._categoryName;
    this._parentId = parentId;
    this._position = position;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._subCategories = subCategories;
    this._count = count;
    this._categoryName = categoryName;
  }

  int get id => _id;
  String get name => _name;
  String get slug => _slug;
  String get icon => _icon;
  String get parentId => _parentId;
  String get position => _position;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get categoryName => _categoryName;
  List<SubCategory> get subCategories => _subCategories;

  Category.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _icon = json['image'];
    _count = json['count'].toString();
    _categoryName = json['name'];
    print("Added to ${_categoryName}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['slug'] = this._slug;
    data['icon'] = this._icon;
    data['parent_id'] = this._parentId;
    data['position'] = this._position;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    if (this._subCategories != null) {
      data['childes'] = this._subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  int _id;
  String _name;
  String _slug;
  Null _icon;
  String _parentId;
  String _position;
  String _createdAt;
  String _updatedAt;
  List<SubSubCategory> _subSubCategories;

  SubCategory(
      {int id,
      String name,
      String slug,
      Null icon,
      String parentId,
      String position,
      String createdAt,
      String updatedAt,
      List<SubSubCategory> subSubCategories}) {
    this._id = id;
    this._name = name;
    this._slug = slug;
    this._icon = icon;
    this._parentId = parentId;
    this._position = position;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._subSubCategories = subSubCategories;
  }

  int get id => _id;
  String get name => _name;
  String get slug => _slug;
  Null get icon => _icon;
  String get parentId => _parentId;
  String get position => _position;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  List<SubSubCategory> get subSubCategories => _subSubCategories;

  SubCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _icon = json['icon'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['childes'] != null) {
      _subSubCategories = new List<SubSubCategory>();
      json['childes'].forEach((v) {
        _subSubCategories.add(new SubSubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['slug'] = this._slug;
    data['icon'] = this._icon;
    data['parent_id'] = this._parentId;
    data['position'] = this._position;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    if (this._subSubCategories != null) {
      data['childes'] = this._subSubCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubSubCategory {
  int _id;
  String _name;
  String _slug;
  Null _icon;
  String _parentId;
  String _position;
  String _createdAt;
  String _updatedAt;

  SubSubCategory(
      {int id,
      String name,
      String slug,
      Null icon,
      String parentId,
      String position,
      String createdAt,
      String updatedAt}) {
    this._id = id;
    this._name = name;
    this._slug = slug;
    this._icon = icon;
    this._parentId = parentId;
    this._position = position;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  String get name => _name;
  String get slug => _slug;
  Null get icon => _icon;
  String get parentId => _parentId;
  String get position => _position;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  SubSubCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _icon = json['icon'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['slug'] = this._slug;
    data['icon'] = this._icon;
    data['parent_id'] = this._parentId;
    data['position'] = this._position;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

class Categories {
  final List<dynamic> categories;
  Categories(this.categories);
}
