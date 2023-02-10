class UserModel{
  String username;
  UserModel({required this.username});

  factory UserModel.fromJson(Map<String,dynamic> jsonData){
    return UserModel(
      username: jsonData['username'] as String
    );
  }

  Map<String,dynamic> toJson ()=>{
     'username' : username
  };
}
