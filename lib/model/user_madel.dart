class User {
  String? id;
  String? email;
  String? password;

  User({this.id,this.email,this.password});

  User.from({this.email,this.password});

  User.fromJson(Map<String,dynamic> json)
  : id = json['id'],
    email =json['email'],
    password =json['password'];

  Map<String,dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
  };

}

class AccountUser {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? confirmpassword;

  AccountUser({this.id,this.email,this.password,this.name,this.phone,this.confirmpassword});

  AccountUser.from({this.email,this.password});

  AccountUser.fromJson(Map<String,dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        password = json['password'],
        confirmpassword = json['confirmpassword'];

  Map<String,dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'password': password,
    'confirmpassword': confirmpassword,
  };

}