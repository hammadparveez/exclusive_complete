class UserModel {
  int id, user_status;

  UserModel(
      {this.id,
      this.user_status,
      this.user_login,
      this.user_email,
      this.user_nicename,
      this.display_name,
      this.user_activation_key,
      this.user_registered,
      this.caps,
      this.allcaps,
      this.roles});

  String user_login,
      user_email,
      user_nicename,
      display_name,
      user_activation_key,
      user_registered;
  Map<String, dynamic> caps, allcaps;
  List<dynamic> roles;

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] != null) {
      final data = json["data"];
      id = int.parse(data["ID"]);
      user_login = data["user_login"];
      user_nicename = data["user_nicename"];
      user_email = data["user_email"];
      user_registered = data["user_registered"];
      user_activation_key = data["user_activation_key"];
      display_name = data["display_name"];
      user_status = int.parse(data["user_status"]);
    }
    caps = json["caps"];
    roles = json["roles"];
  }
}
