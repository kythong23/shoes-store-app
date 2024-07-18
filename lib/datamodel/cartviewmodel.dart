import 'package:flutter/cupertino.dart';
import 'package:lab8_9_10/datamodel/shoes.dart';

class CartVM with ChangeNotifier{
  List<Shoes> lst = [];
  int discount=0;
  List<Map<String, dynamic>> lstpro = [];
  add(Shoes shoes,int amount){
    if((lst.where((e) => e.id == shoes.id)).isEmpty){
      lst.add(shoes);
        lstpro.add({
          "shoes":shoes,
          "amount":amount,
          "discount":""
        });
    }
    else{
      final index = lstpro.indexWhere((element) => element["shoes"] == shoes);
      if(index != -1){
        lstpro[index]['amount']=lstpro[index]['amount']+amount;
      }
    }
    notifyListeners();
  }
  minusamount(Shoes shoes){
    final index = lstpro.indexWhere((element) => element["shoes"] == shoes);
    if(index != -1){
      lstpro[index]['amount']=lstpro[index]['amount']-1;
    }
    notifyListeners();
  }
  int totalamount(){
    int total=0;
    for(var pro in lstpro){
      total += pro['amount'] as int;
    }
    return total;
  }
  double totalwithdiscount(){
    double total=0;
    for(var pro in lstpro){
      Shoes s = pro['shoes'];
      int price = s.price!*pro['amount'] as int;
      total += price;
    }
    total = total - (total*discount/100);
    return total;
  }
  int totalmoney(){
    int total=0;
    for(var pro in lstpro){
      Shoes s = pro['shoes'];
      int price = s.price!*pro['amount'] as int;
      total += price;
    }
    return total;
  }
  clearall(){
    lst.clear();
    lstpro.clear();
    notifyListeners();
  }
  del(int index){
    lst.removeAt(index);
    lstpro.removeAt(index);
    notifyListeners();
  }
}