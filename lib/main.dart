//=======================================================================================================================================================//
//========================================================= Main dart ===================================================================================//
//=======================================================================================================================================================//
//=========================================================================//
//======| Data create     : 16 october 2019                 |======//
//======| Programmer      : dhikihandika                    |======//
//======| Email           : dhikihandika36@gmail.com        |======//
//======| Github          : @dhikihandika                   |======//
//=========================================================================//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_app/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/screen/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: "login menu Flutter",
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ///==================================================================================================///
  ///===================================== User Login Controller ======================================///
  ///==================================================================================================///
  final _key = new GlobalKey<FormState>();

  bool _secureText = false;

  // Method show hide text
  showhide(){
   setState(() {
     _secureText = !_secureText;
   });
  }
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  check(){
    final form = _key.currentState;
    if(form.validate()){
      form.save();
      //print("$user, $pass");
      login();
    }
  }

  final String baseUrl = "http://10.0.2.2:8080";
  Future<bool> postData(LoginData data) async {
    final response = await http.post(
      "$baseUrl/post/vawtuserlogin",
      headers: {"content-type": "application/json"},
      body: logindataToJson(data),
    );
    var datauser = json.decode(response.body);      // Save response.body to variable "datauser"
    print(datauser);                                // Print return response.body of post data
    if(datauser.length == 0){                       // if length data save in variable 'datauser' = 0
      print("Login user failed");
    } else {
      if(datauser[0]['level']=='member'){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    }
  }

  login() {
    setState(() {
      String username = user.text.toString();
      String password = pass.text.toString();

      LoginData logindata = LoginData(username: username, password: password);
      postData(logindata);
    });
  }

  ///==================================================================================================///
  ///========================================== Build Method ==========================================///
  ///==================================================================================================///

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Login menu vawt"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child:
                IconButton(
                  icon: Icon(Icons.account_circle, color: Colors.redAccent),
                  onPressed: null,
                  iconSize: 90.00,
                )
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.00),
            ),
            Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  TextFormField(
                    validator: (e){
                      if(e.isEmpty){
                        return("Please insert username");
                      }
                    },
                    controller: user,
                    decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "username...",
                        contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                  TextFormField(
                    validator: (e){
                      if(e.isEmpty){
                        return("Please insert your password");
                      }
                    },
                    obscureText: _secureText,
                    controller: pass,
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "password...",
                        contentPadding: EdgeInsets.all(10.0),
                        suffixIcon: IconButton(
                          onPressed: showhide,
                          icon: Icon(Icons.visibility_off),
                        )
                    ),
                  ),
                  RaisedButton(
                    child: Text("Login"),
                    onPressed: (){
                      check();
                    },
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}