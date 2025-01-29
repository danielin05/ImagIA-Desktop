class UserModel {
  int id;
  String nickname;
  String email;
  String plan;

  UserModel(this.id, this.nickname,this.email, this.plan);

  UserModel.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    nickname = json['nickname'],
    email = json['email'],
    plan = json['plan'];
}