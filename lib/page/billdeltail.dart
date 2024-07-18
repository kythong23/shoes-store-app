
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../datamodel/bill.dart';

class HistoryDetail extends StatelessWidget {
  final List<BillDetailModel> bill;
  final BillModel billModel;
  const HistoryDetail({super.key, required this.bill, required this.billModel});

  @override
  Widget build(BuildContext context) {
    int total = 0;
    for(var data in bill)
      total+=data.total!;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: HexColor("EEEEF3"),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              margin: new EdgeInsets.only(left: 20,top: 20,right: 20),
              child:
              Row(
                children: [
                  Column(children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width*0.75
                      ),
                      child: Text("Invoice: ${billModel.id.toString()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    )
                  ],),
                  Spacer(),
                  Icon(FontAwesomeIcons.solidCircleCheck,color: HexColor("#63E6BE"),),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              margin: new EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Customer: ${billModel.fullName!.toUpperCase()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      Spacer(),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person,size: 50,),
                      ),
                    ],
                  ),
                  Text('DateCreated: ' + billModel.dateCreated),
                  Divider(),
                  for(var data in bill)
                    detailList(data),
                  Divider(),
                  Row(
                    children: [
                      Text("Grand total:", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Spacer(),
                      Text(
                        NumberFormat('#,##0').format(total),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget detailList(BillDetailModel data){
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Image.network(data.imageUrl,width: 100,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    NumberFormat('#,##0').format(data.price),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                  ),
                  Text("x ${data.total/data.price} Item",style:
                  TextStyle(
                      color: Colors.redAccent
                  ),),
                  Container(
                      constraints: BoxConstraints(
                          maxWidth: 250
                      ),
                      child: Text(data.productName)),
                  SizedBox(height: 20,)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}