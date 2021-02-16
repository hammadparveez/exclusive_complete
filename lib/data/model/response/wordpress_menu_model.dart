class WordPressMenuModel {
  List items;
  WordPressMenuModel(List items) {
    this.items = items;
  }
  //WordPressMenuModel.toJSON(Map<String, dynamic> menu) {}
}

class WordPressMenuItemModel {
  int id, order, parent;
  String title, url;

  WordPressMenuItemModel.fromJson(Map<String, dynamic> items) {
    id = items["id"];
    order = items["order"];
    title = items["title"];
    url = items["url"];
  }
}
