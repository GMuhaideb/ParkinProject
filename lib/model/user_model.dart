// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final String name;
  final String image;
  final String email;
  final bool type;
  final String uId;
  final String stickerId;

  UserModel({
    required this.name,
    required this.image,
    required this.email,
    required this.type,
    required this.uId,
    required this.stickerId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'type': type,
      'uId': uId,
      'image': image,
      'stickerId': stickerId,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      type: map['type'] as bool,
      uId: map['uId'] as String,
      image: map['image'] as String,
      stickerId: map['stickerId'] as String,
    );
  }
}
