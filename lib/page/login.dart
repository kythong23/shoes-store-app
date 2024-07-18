import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:lab8_9_10/page/navigationbottom.dart';
import 'package:lab8_9_10/page/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/api_service.dart';
import '../datamodel/User.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _accountcontroller =TextEditingController();
  final TextEditingController _passwordcontroller =TextEditingController();
  late String token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9"
                    "GcTC6m6K8hRBoyEC9VqfmGX4sq4GHK79P-pq4N-PDOYdhZZu2cTE"),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("User name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
                    SizedBox(height: 8),
                    TextField(
                      controller: _accountcontroller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Input your name / mail',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
                    SizedBox(height: 8),
                    TextField(
                      controller: _passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: 'Input your password',
                          prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ],
                ),
              ),
              GFButton(
                onPressed: (){
                  Login(_accountcontroller.text, _passwordcontroller.text);
                },
                size: GFSize.LARGE,
                child: SizedBox(
                  width: 200,
                  child:
                    Text('Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),),
                ),
                color: Colors.black,
                shape: GFButtonShape.pills,
              ),
              Text("Or login with"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GFButton(
                    onPressed: (){},
                    text: "Facebook",
                    icon: Icon(Icons.facebook),
                    shape: GFButtonShape.pills,
                  ),
                  SizedBox(width: 8),
                  GFButton(
                    onPressed: (){},
                    color: Colors.grey,
                    text: "Icloud",
                    icon: Icon(Icons.apple),
                    shape: GFButtonShape.pills,
                  ),
                  SizedBox(width: 8),
                  GFButton(
                    onPressed: (){},
                    text: "Google",
                    color: Colors.redAccent,
                    icon: FaIcon(FontAwesomeIcons.google),
                    shape: GFButtonShape.pills,
                  ),
                ],
              ),
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                  text: "Don't have any account? ",
                  style: TextStyle(color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(text: 'Sign up', style: TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()..onTap=(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Register()));
                    },),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void Login(String a,String p)async{
    String loginresult = await APIRepository().login(a,p);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(loginresult != "login fail"){
      token = loginresult;
      User user = await APIRepository().getCurrentUser(token);
      prefs.setString("token", token);
      prefs.setString("user", jsonEncode(user));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Bottom_NavigationWidget(token: token,),
          settings: RouteSettings(name: '/Bottom_NavigationWidget')));
    }
    else{
      showDialog(context: context,
          builder: (context)=> SimpleDialog(
            title: Text("Login Error"),
            contentPadding: EdgeInsets.all(20),
            children: [
              Text("Login fail ! Please check your account and password"),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("OK"))
            ],
          ));
    }
  }
}
