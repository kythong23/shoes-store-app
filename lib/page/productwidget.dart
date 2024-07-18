import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../datamodel/cartviewmodel.dart';
import '../datamodel/shoes.dart';

Widget listCartItem(Map<String,dynamic> shoes,int index){
  Shoes s = shoes['shoes'];
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(244, 242, 246, 1),
            borderRadius: BorderRadius.circular(16)
        ),
        padding: EdgeInsets.all(13),
        child: Row(
          children: [
            Image.network(s.imageURL!,width: 100,),
            SizedBox(width: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 160,
                  ),
                  child: Text(s.name!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                ),
                SizedBox(height: 10,),
                Text(NumberFormat.currency(locale: 'vi',
                    symbol: 'đ').format(s.price),
                  style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Row(
                    children: [
                      Consumer<CartVM>(builder:(context,value,child)=>
                          GestureDetector(
                              onTap:shoes['amount']>1?(){
                                value.minusamount(s);
                              }:(){},
                              child: Padding(
                                padding:const EdgeInsets.only(left: 9,right: 9),
                                child: Icon(FontAwesomeIcons.minus,size: 15,),
                              )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 9,right: 9),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(),
                            right: BorderSide(),
                          ),
                        ),
                        child: Text(shoes['amount'].toString(),style: TextStyle(
                            fontSize: 18
                        ),),
                      ),
                      Consumer<CartVM>(builder:(context,value,child)=>
                          GestureDetector(onTap: (){
                            value.add(s,1);
                          }, child: Padding(
                            padding:const EdgeInsets.only(left: 9,right: 9),
                            child: Icon(FontAwesomeIcons.plus,size: 15,),
                          )),),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Consumer<CartVM>(
                builder: (context, value, child) => IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                    size: 24,
                  ),
                  onPressed: (){
                    value.del(index);
                  },
                )
            ),
          ],
        ),
      ),
      SizedBox(height: 12,)
    ],
  );
}
Widget listCheckout(Map<String,dynamic> shoes,int index){
  Shoes s = shoes['shoes'];
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(244, 242, 246, 1),
            borderRadius: BorderRadius.circular(16)
        ),
        padding: EdgeInsets.all(13),
        child: Row(
          children: [
            Image.network(s.imageURL!,width: 100,),
            SizedBox(width: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width:200,
                  child: Text(s.name!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  overflow: TextOverflow.ellipsis,),
                ),
                SizedBox(height: 18,),
                Text(NumberFormat.currency(locale: 'vi',
                    symbol: 'đ').format(s.price),
                  style: TextStyle(fontSize: 18),),
              ],
            ),
            Spacer(),
            Consumer<CartVM>(
                builder: (context,value,child)=>
            Text("x${value.lstpro[index]['amount']}",style: TextStyle(fontSize: 17),)),
          ],
        ),
      ),
      SizedBox(height: 12,)
    ],
  );
}