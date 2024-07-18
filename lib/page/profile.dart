import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab8_9_10/page/billscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datamodel/User.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  User user = new User();
  bool _isLoading = true;

  void getuser()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user = User.fromJson(jsonDecode(prefs.getString("user")!));
    if(user != null){
      setState(() {
        _isLoading = false;
      });
    }
  }
  void logout()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    Navigator.of(context).pop();
  }
  @override
  void initState() {
    super.initState();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 250,
                color: Color.fromRGBO(61,114,164, 1),
              )),
          Positioned(
              top: 45,
              left: 0,
              right: 0,
              child: Container(
                child: Center(
                  child:
                    Text("Profile",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white
                    ),),
                ),
              )),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(228,229,231, 1),
              ),
              height: 200,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person,size: 64,),
                  ),
                  (!_isLoading)?
                  Text(
                    user.fullName!.toUpperCase(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ):Text(
                    "No data",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Members"),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top:330,
              left: 20,
              right: 20,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color.fromRGBO(49, 49, 49, 1000),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text("My Orders",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: 30,),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text("💳",
                                              style: TextStyle(
                                                fontSize: 30
                                              ),),
                                              Text(
                                                'Payment',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const HistoryScreen()));
                                          },
                                          child: Expanded(
                                            child: Column(
                                              children: [
                                                Icon(Icons.ballot,size: 45,),
                                                Text(
                                                  'Bill History',
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text("✖️",
                                                style: TextStyle(
                                                    fontSize: 30
                                                ),),
                                              Text(
                                                'Cancelled',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text("🗺️",
                                                style: TextStyle(
                                                    fontSize: 30
                                                ),),
                                              Text(
                                                'Address',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text("🎟️",
                                                style: TextStyle(
                                                    fontSize: 30
                                                ),),
                                              Text(
                                                'Coupons',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text("💬",
                                                style: TextStyle(
                                                    fontSize: 30
                                                ),),
                                              Text(
                                                'Customer Care',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 70,),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Text("Edit profile",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                )),
                            Spacer(),
                            Icon(FontAwesomeIcons.edit),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Divider(),
                        SizedBox(
                          width: 100,
                          child: InkWell(
                            onTap: (){
                              logout();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.rightFromBracket),
                                Text("Log out",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  )),),
        ]
      ),
    );
  }
}
