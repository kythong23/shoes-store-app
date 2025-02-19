import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/api_service.dart';
import '../datamodel/bill.dart';
import 'billdeltail.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  Future<List<BillModel>> _getBills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await APIRepository().getHistory(prefs.getString('token').toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill history"),
      ),
      body: FutureBuilder<List<BillModel>>(
          future: _getBills(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final itemBill = snapshot.data![index];
                  return _billWidget(itemBill, context);
                },
              ),
            );
          },
        ),
    );
  }

  Widget _billWidget(BillModel bill, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var temp = await APIRepository().getHistoryDetail(bill.id, prefs.getString('token').toString());
        Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetail(bill: temp,billModel: bill,)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                child: Text(
                  bill.id.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.fullName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      NumberFormat('#,##0').format(bill.total),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.red,
                      ),
                    ),
                    // const SizedBox(height: 4.0),
                    // Text('Category: ${pro.catId}'),
                    const SizedBox(height: 4.0),
                    Text('DateCreated: ' + bill.dateCreated),
                  ],
                ),
              ),
              GFButton(
                onPressed: ()async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  var temp = await APIRepository().getHistoryDetail(bill.id, prefs.getString('token').toString());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetail(bill: temp,billModel: bill,)));
                },
                child: Text("Check",style: TextStyle(color: Colors.black),),
                color: HexColor("#63E6BE"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
