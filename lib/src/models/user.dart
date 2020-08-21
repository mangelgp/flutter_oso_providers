
class Users {
  List<User> items = new List();

  Users();

  Users.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final user = new User.fromJson(item);
      items.add(user);     
    }
  }
}

class User {
  User({
    this.idUser,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.verified,
    this.admin,
    this.createdAt,
    this.updatedAt,
  });

  int idUser;
  String name;
  String email;
  String emailVerifiedAt;
  String verified;
  String admin;
  String createdAt;
  String updatedAt;

  // factory User.fromJson(Map<String, dynamic> json) => User(
  //   idUser            : json['id'],
  //   name              : json['name'],
  //   email             : json['email'],
  //   emailVerifiedAt   : json['email_verified_at'],
  //   verified          : json['verified'],
  //   admin             : json['admin'],
  //   createdAt         : json['created_at'],
  //   updatedAt         : json['updated_at'],
  // );

  User.fromJson(Map<String, dynamic> json) {
    idUser            = json['id'];
    name              = json['name'];
    email             = json['email'];
    emailVerifiedAt   = json['email_verified_at'];
    verified          = json['verified'];
    admin             = json['admin'];
    createdAt         = json['created_at'];
    updatedAt         = json['updated_at'];
  }

  // Map<String, String> toJson() => {
  //   "name"      : 
  //   "email"     :
  //   "password"  :
  // };
}
