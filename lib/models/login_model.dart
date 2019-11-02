//=======================================================================================================================================================//
//========================================================= CLass Model "data user login" ===============================================================//
//=======================================================================================================================================================//
//=========================================================================//
//======| Data create     : 16 october 2019                 |======//
//======| Programmer      : dhikihandika                    |======//
//======| Email           : dhikihandika36@gmail.com        |======//
//======| Github          : @dhikihandika                   |======//
//=========================================================================//
import 'dart:convert';

class LoginData {
  String username;
  String password;

  LoginData({this.username, this.password});

  factory LoginData.fromJson(Map<String, dynamic> map) {
    return LoginData(
        username: map["username"],
        password: map["password"]
    );
  }

  Map<String, dynamic> toJson() {
    return {"username": username, "password":password};
  }

  @override
  String toString(){
    return 'LoginData{username: $username, password: $password}';
  }
}

List<LoginData>  logindataFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<LoginData>.from(data.map((item) => LoginData.fromJson(item)));
}

String logindataToJson(LoginData data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

