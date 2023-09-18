class ChatUser {
  ChatUser({
    required this.createdAt,
    required this.image,
    required this.lastActive,
    required this.about,
    required this.name,
    required this.id,
    required this.isOnline,
    required this.email,
    required this.pushToken,
  });
  late  String createdAt;
  late  String image;
  late  String lastActive;
  late  String about;
  late  String name;
  late  String id;
  late  bool isOnline;
  late  String email;
  late  String pushToken;

  ChatUser.fromJson(Map<String, dynamic> json){
    createdAt = json['createdAt'] ?? "";
    image = json['image'] ?? "";
    lastActive = json['lastActive'] ?? "";
    about = json['about'] ?? "";
    name = json['name'] ?? "";
    id = json['id'] ?? "";
    isOnline = json['is_online'] ?? "";
    email = json['email'] ?? "";
    pushToken = json['push_token'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createdAt'] = createdAt;
    _data['image'] = image;
    _data['lastActive'] = lastActive;
    _data['about'] = about;
    _data['name'] = name;
    _data['id'] = id;
    _data['is_online'] = isOnline;
    _data['email'] = email;
    _data['push_token'] = pushToken;
    return _data;

  }


}



