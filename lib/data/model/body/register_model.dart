class RegisterModel {
  String email;
  String password;
  String fName;
  String lName;
  String userName;

  RegisterModel(
      {this.email, this.password, this.fName, this.lName, this.userName});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    fName = json['first_name'];
    lName = json['last_name'];
    userName = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['username'] = this.userName;

    return data;
  }
}
