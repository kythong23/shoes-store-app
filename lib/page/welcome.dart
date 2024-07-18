import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:lab8_9_10/page/login.dart';
import 'package:lab8_9_10/page/navigationbottom.dart';
import 'package:lab8_9_10/page/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Welcome"),
        ),
      body: Container(
        width: double.infinity,
        child: Column(
            children: [
              Image.network("https://t3.ftcdn.net/jpg/00/82/88/66/360"
                  "_F_82886619_a4xje5obM5bAajAjnx6ZzWb0Is70kSQA.jpg"),
              Text("Comfort is",
              style: TextStyle(
                fontSize: 30,
              ),),
              Text("Everything",
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(18, 93, 224, 1)
                ),),
              Text("Find the best shoes for yourself",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: 20,
                ),),
              GFButton(
                onPressed: (){
                  checkuser();
                },
                color: Color.fromRGBO(49, 49, 49, 1),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: < Widget > [
                    Text("Login"),
                    Icon(Icons.login,color: Colors.white,),
                  ],
                ),
                shape: GFButtonShape.pills,
              ),
              GFButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Register()));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: < Widget > [
                    Text("Register"),
                    Icon(Icons.app_registration,color: Colors.white,),
                  ],
                ),
                color: Color.fromRGBO(49, 49, 49, 1),
                shape: GFButtonShape.pills,
              ),
            ],
        ),
      ),
    );
  }
  void checkuser()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      String userjson = prefs.getString("user")!;
      String token = prefs.getString("token")!;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Bottom_NavigationWidget(token: token),settings: RouteSettings(name: "/Bottom_NavigationWidget")));
    }catch(e){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginWidget()));
    }
  }
}