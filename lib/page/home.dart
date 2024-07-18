import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:lab8_9_10/const/api_service.dart';
import 'package:lab8_9_10/datamodel/categories.dart';
import 'package:lab8_9_10/page/detail.dart';

import '../datamodel/shoes.dart';

class HomeWidget extends StatefulWidget {
  String token;
  HomeWidget({super.key,required this.token});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _selectindex=0;
  String cateselect = "";
  late Future<List<Categories>> futureCategories;
  late Future<List<Shoes>> futureShoes;
  List<Shoes> searchResult = [] ;
  List<Shoes> allshoes = [] ;
  List<Shoes> shosecate = [] ;
  void shoesbycate(String cate){
    setState(() {
      shosecate = allshoes.where((element) => element.categoryName!.contains(cate)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width *0.8,
                  child: TextField(
                    onChanged: (value){
                      if(value.isEmpty)
                      {
                        setState(() {
                          searchResult.clear();
                        });
                      }
                      else{
                        setState(() {
                          searchResult = allshoes.where((element) => element.name!.toLowerCase().contains(value)).toList();
                        });
                      }
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search)
                    ),
                  ),
                ),
              ],
            ),
            (searchResult.length >0)?
            Container(
              // color: Colors.white,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: searchResult.length,
                  itemBuilder: (context,index ){
                    return itemListView(searchResult[index],this.context,allshoes);
                  }),
            ):
            Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Align(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Image.network
                          ("https://static.vecteezy.co"
                            "m/system/resources/previews/0"
                            "08/564/775/non_2x/sport-shoes-b"
                            "anner-for-website-with-button-ui-"
                            "design-illustration-vector.jpg",
                          fit: BoxFit.cover,)),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child:Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                      Expanded(
                        flex: 4,
                        child: Container(),),
                      Expanded(
                        flex: 2,
                        child: Text("See all"),)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FutureBuilder(
                        future: futureCategories,
                        builder: (context,snapshot){
                          if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Hiển thị tiến trình chờ
                          } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
                          } else {
                          // Xử lý kết quả từ Future và hiển thị CarouselSlider
                          List<Categories> listcate = snapshot.data!;
                          return Row(
                            children: listcate.map((item) {
                            return Row(
                              children: [
                                GFButton(
                                  onPressed: () {
                                    setState(() {
                                      cateselect = item.name!;
                                      _selectindex =1;
                                    });
                                    shoesbycate(item.name!);
                                  },
                                  color: item.name == cateselect ? Colors.grey : Colors.white,
                                  borderSide: item.name == 'nike' ? BorderSide(color: Colors.black) : BorderSide(color: Colors.black),
                                  child: Image.network(
                                    item.imageURL!,
                                    fit: BoxFit.cover,
                                  ),
                                  shape: GFButtonShape.standard,
                                ),
                                SizedBox(width: 20,),
                              ],
                            );
                          }).toList(),
                            );
                          }
                        }),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left:25),
                  child: (_selectindex==0)?FutureBuilder(
                  future: futureShoes,
                  builder: (context,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Hiển thị tiến trình chờ
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
                    } else {
                      // Xử lý kết quả từ Future và hiển thị CarouselSlider
                      List<Shoes> lstshose = snapshot.data!;
                      return Wrap(
                        spacing: 40,
                        children: lstshose.map((item) {
                          return Container(
                            width: 170,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailWidget(shoes: item,listshoes: lstshose,)));
                              },
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(246,246,246, 1),
                                          borderRadius: BorderRadius.circular(16)
                                        ),
                                        child: Image.network(item.imageURL!,width: 150,),
                                      ),
                                      Container(
                                        height:40,
                                        constraints: BoxConstraints(
                                          maxWidth: 150,
                                        ),
                                        child: Text(
                                          item.name!
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.currency(locale: 'vi', symbol: 'đ').format(item.price),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20,)
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  }):FutureBuilder(
                      future: futureShoes,
                      builder: (context,snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Hiển thị tiến trình chờ
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
                        } else {
                          // Xử lý kết quả từ Future và hiển thị CarouselSlider
                          List<Shoes> lstshose = shosecate;
                          return SingleChildScrollView(
                            child: Column(
                              children: lstshose.map((item) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailWidget(shoes: item,listshoes: lstshose,)));
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(246,246,246, 1),
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          child: Image.network(item.imageURL!,width: 150,),
                                        ),
                                        SizedBox(width: 20,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height:70,
                                              constraints: BoxConstraints(
                                                maxWidth: 150,
                                              ),
                                              child: Text(
                                                  item.name!,
                                              ),
                                            ),
                                            Text(
                                              NumberFormat.currency(locale: 'vi', symbol: 'đ').format(item.price),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }
                      })
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget itemListView (Shoes shoes,BuildContext context,List<Shoes> listshoes){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailWidget(shoes: shoes, listshoes: listshoes)));
      },
      child: Container(
                  color: Colors.black12,
                  child:
                  Row(
                    children: [
                      Image.network(
                        width: 100,
                        height: 100,
                        shoes.imageURL!,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(width: 10,),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 280
                        ),
                        child: Text(shoes.name!,
                          style: TextStyle(
                            // color: Colors.white,
                          ),),
                      ),
                    ],
                  )
              ),
    );
  }
  Future<List<Shoes>> _loginAndFetchShoes() async {
    return await APIRepository().listShoes('21dh112976', widget.token);
  }
  Future<List<Categories>> _loginAndFetchCategories() async {
    return await APIRepository().listCate('21dh112976', widget.token);
  }
  void _fetchData()async{
    setState(() {
      futureShoes = _loginAndFetchShoes();
      futureCategories = _loginAndFetchCategories();
    });
    allshoes = await _loginAndFetchShoes();
  }
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

}
