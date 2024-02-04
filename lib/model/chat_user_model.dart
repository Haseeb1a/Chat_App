class CharUser {
  late final String name;
  late final String image;
  late final String about;
  late final String id;
  late final bool isOnline;
  late final String createdAt;
  late final String isActive;
  late final String email;
  late final String pushTocken;

  CharUser({
    required this.name,
    required this.image,
    required this.about,
    required this.id,
    required this.createdAt,
    required this.isOnline,
    required this.isActive,
    required this.email,
    required this.pushTocken,
  });

  CharUser.fromJson(Map<String, dynamic> json) {
    name = json['name']??'';
    image = json['image']??'';
    about = json['about']??'';
    isOnline = json['is_online']??'';
    id = json['id'];
    createdAt = json['created_at']??'';
    isActive = json['last_active']??'';
    email = json['email']??'';
    pushTocken = json['push_token']??'';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['about'] = about;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['last_active'] = isActive;
    data['email'] = email;
    data['image'] = pushTocken;
    return data;
  }
}
