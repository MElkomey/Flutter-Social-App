class UserModel{
  String? email;
  String? phone;
  String? uId;
  String? name;
  bool? isEmailVerified;
  String? bio;
  String? image;
  String? cover;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEmailVerified,
    this.bio,
    this.image,
    this.cover,
});

  UserModel.fromjson(json){
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    name=json['name'];
    isEmailVerified=json['isEmailVerified'];
    bio=json['bio'];
    image=json['image'];
    cover=json['cover'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
      'bio':bio,
      'image':image,
      'cover':cover,
    };
  }

}
