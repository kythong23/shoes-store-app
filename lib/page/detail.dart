import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:lab8_9_10/datamodel/shoes.dart';
import 'package:lab8_9_10/page/mycart.dart';
import 'package:provider/provider.dart';

import '../datamodel/cartcounter.dart';
import '../datamodel/cartviewmodel.dart';

class DetailWidget extends StatefulWidget {
  final Shoes shoes;
  final List<Shoes> listshoes;
  const DetailWidget({super.key, required this.shoes,required this.listshoes});

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  int amount = 1;
  @override
  Widget build(BuildContext context) {
    Shoes shoes = widget.shoes;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail",),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CartWidget()));
                }, icon: Icon(Icons.shopping_bag)),
                Positioned(
                  top: 0,
                  left: 0,
                  right: -20,
                  child: Consumer<CartVM>(
                    builder: (context,value,child)=>CartCounter(count: value.lst.length.toString())
                    ,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(172,173,170, 1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(26),
                            bottomRight: Radius.circular(26),
                          ),
                        ),
                        child: Align(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(shoes.imageURL!),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Text(
                                shoes.name!,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 18),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 1,
                              child: Icon(FontAwesomeIcons.coins),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                NumberFormat.currency(locale: 'vi', symbol: 'đ').format(shoes.price),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Others "+shoes.categoryName!.toUpperCase()+" shoes"),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: widget.listshoes.where((e) => e.categoryName==shoes.categoryName && e.name != shoes.name).map((e){
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    width: 100,
                                    height: 100,
                                    child: InkWell(
                                        onTap: (){
                                          Navigator.of(context).pop();
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailWidget(shoes: e, listshoes: widget.listshoes)));
                                        },
                                        child: Image.network(e.imageURL!)),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 30,
                        child: GFButton(onPressed:amount>1? (){
                          setState(() {
                            amount--;
                          });
                        }:(){}
                            , child: Icon(FontAwesomeIcons.minus,color: Colors.white,),
                          color: Color.fromRGBO(49, 49, 49, 1),
                        shape: GFButtonShape.standard,),
                      ),
                      SizedBox(width: 10,),
                      Text(amount.toString(),
                      style: TextStyle(
                        fontSize: 20
                      ),),
                      SizedBox(width: 10,),
                      SizedBox(
                        width: 40,
                        height: 30,
                        child: GFButton(onPressed:(){
                          setState(() {
                            amount++;
                          });
                        }
                          , child: Icon(FontAwesomeIcons.plus,color: Colors.white,),
                          color: Color.fromRGBO(49, 49, 49, 1),
                          shape: GFButtonShape.standard,),
                      ),
                    ],
                  ),
                ),
                Consumer<CartVM>(
                    builder: (context,value,child)=>Container(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            value.add(shoes,amount);
                          },
                          child: Text('Buy now',
                            style: TextStyle(
                                color: Colors.white
                            ),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(49, 49, 49, 1),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
