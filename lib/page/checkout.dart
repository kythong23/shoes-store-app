import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lab8_9_10/page/productwidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/api_service.dart';
import '../datamodel/User.dart';
import '../datamodel/cartviewmodel.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  User user = new User();
  bool _isLoading = true;
  String token='';
  void getuser()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user = User.fromJson(jsonDecode(prefs.getString("user")!));
    token = prefs.getString("token")!;
    if(user != null){
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              color:HexColor("#FF8000"),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.exclamation),
                  SizedBox(width: 8,),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width*0.8
                    ),
                    child: Text(
                        "Before making an order, make sure the address is correct and matches your current address"
                    ,style: GoogleFonts.nunito(
                      fontSize:15,
                    ),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width:MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width:MediaQuery.of(context).size.width*0.7,
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.locationDot,color: HexColor("#63E6BE"),),
                                  SizedBox(width: 5,),
                                  (!_isLoading)
                                  ?Text(user.fullName!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),)
                                      :Text("No data"),
                                  Spacer(),
                                  (!_isLoading)
                                      ?Text(user.phoneNumber!)
                                      :Text("000-000"),
                                ],
                              ),
                            ),
                            Text(
                              "300 Nguyen Xi, P.21, Q.Binh Thanh, TP.HCM"
                            ,style: GoogleFonts.nunito(
                              fontWeight:FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Your order"
                  ,style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(
                    height: 430,
                    child: Consumer<CartVM>(
                        builder: (context,value,child)=>ListView.builder(
                            itemCount: value.lst.length,
                            itemBuilder: (context, index){
                              return listCheckout(value.lstpro[index],index);
                            })),
                  ),
                  Divider(thickness: 4,color: Colors.black,),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total payment",
                                style: TextStyle(
                                    fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("#393939"),
                                ),),
                              Consumer<CartVM>(builder:(context,value,child)=>
                                  Text(NumberFormat.currency(locale: 'vi',
                                      symbol: 'đ').format(value.totalwithdiscount()),
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: HexColor("FF7F5B"),
                                        fontWeight: FontWeight.bold
                                    ),)),
                            ],
                          )),
                      Consumer<CartVM>(
                          builder: (context,value,child)=>
                              Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: GFButton(
                                      onPressed: ()async{
                                        SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                        await APIRepository()
                                            .addBill(value.lstpro, pref.getString('token').toString());
                                        AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.bottomSlide,
                                            showCloseIcon: true,
                                            title: "Order Success",
                                            desc: "Your order has been placed, thanks for your shopping",
                                            btnOkOnPress: (){
                                              value.clearall();
                                              Navigator.popUntil(context, ModalRoute.withName('/Bottom_NavigationWidget'));
                                            }
                                        ).show();
                                      },
                                      child: Text("Pay",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                      color: HexColor("#FF8000"),
                                    ),
                                  )),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
