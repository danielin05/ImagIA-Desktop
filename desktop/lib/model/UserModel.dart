class UserModel {
  int id;
  String nickname;
  String email;
  String plan;
  int quota;
  UserModel(this.id, this.nickname,this.email, this.plan, this.quota);

  UserModel.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    nickname = json['nickname'],
    email = json['email'],
    plan = json['planning'],
    quota = json['availableQuota'];
}