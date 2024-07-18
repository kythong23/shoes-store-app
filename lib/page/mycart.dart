import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:lab8_9_10/datamodel/cartviewmodel.dart';
import 'package:lab8_9_10/page/checkout.dart';
import 'package:lab8_9_10/page/productwidget.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  List _voucher = [];
  int discount=0;
  String vouchercontent = "Click to add voucher";
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/voucher.json');
    final data = await json.decode(response);
    setState(() {
      _voucher = data["voucher"];
    });
  }
  void checkvoucher(String _inputvoucher){
    bool checkvalue = true;
    for(var voucher in _voucher)
      if(voucher["name"].toString().toLowerCase()==_inputvoucher.toLowerCase()){
        setState(() {
          vouchercontent = voucher["name"].toString();
          discount = int.parse(voucher["description"]??'1');
        });
        checkvalue = false;
        Navigator.of(context).pop();
      }
    if(checkvalue)
      Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Cart",),
      ),
      body: Consumer<CartVM>(
    builder: (context,value,child)=>(value.lst.length>0) ?Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 450,
                child: Consumer<CartVM>(
                    builder: (context,value,child)=>ListView.builder(
                        itemCount: value.lst.length,
                        itemBuilder: (context, index){
                          return listCartItem(value.lstpro[index],index);
                        })),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(),
                ),
                child: InkWell(
                  onTap: (){
                    inputVoucher(this.context,_voucher);
                  },
                  child: Row(
                    children: [
                      Text("🎟️  Voucher ",
                        style: TextStyle(
                            fontSize: 20,
                        ),),
                      Spacer(),
                      Opacity(
                        opacity: 0.5,
                        child: Text(vouchercontent,
                          style: TextStyle(
                              fontSize: 17
                          ),),
                      ),
                     Icon(Icons.arrow_right),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Discount: ",
                    style: TextStyle(
                        fontSize: 17
                    ),),
                  Spacer(),
                  Consumer<CartVM>(builder:(context,value,child)=>
                      Text("$discount%",
                        style: TextStyle(
                            fontSize: 17
                        ),)),
                ],
              ),
              new Padding(
                  padding: EdgeInsets.all(0.0),
                  child: new Divider()
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Total amount: ",
                  style: TextStyle(
                    fontSize: 17
                  ),),
                  Spacer(),
                  Consumer<CartVM>(builder:(context,value,child)=>
                    Text(value.totalamount().toString(),
                      style: TextStyle(
                          fontSize: 17
                      ),)),
                ],
              ),
              new Padding(
                  padding: EdgeInsets.all(0.0),
                  child: new Divider()
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Total price: ",
                    style: TextStyle(
                        fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),),
                  Spacer(),
                  Consumer<CartVM>(builder:(context,value,child)=>
                      Text(NumberFormat.currency(locale: 'vi',
                          symbol: 'đ').format((value.totalmoney()-(value.totalmoney()*discount/100))),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),)),
                ],
              ),
              new Padding(
                  padding: EdgeInsets.all(0.0),
                  child: new Divider()
              ),
              SizedBox(
                width: 400,
                height:50,
                child: GFButton(onPressed: (){
                  value.discount =discount;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkout()));
                },
                text: "Checkout", color: Color.fromRGBO(49, 49, 49, 1),
                shape: GFButtonShape.pills,),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ):Center(child: Text("Cart empty"),),
    )
    );
  }
   inputVoucher(BuildContext context,List item)async{
    return (!item.isEmpty)?showDialog(context: context,
        builder: (context){
      final TextEditingController _inputvoucher = TextEditingController();
      return AlertDialog(
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _inputvoucher,
                validator: (value){
                  return value!.isNotEmpty ? null : 'Invalid Field';
                },
                decoration: InputDecoration(hintText: 'Enter your voucher'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              checkvoucher(_inputvoucher.text);
            },
            child: Text("OK")),
        ],
      );
        }):CircularProgressIndicator();
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }
}
