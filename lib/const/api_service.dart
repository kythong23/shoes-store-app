import 'package:dio/dio.dart';
import 'package:lab8_9_10/datamodel/User.dart';
import 'package:lab8_9_10/datamodel/categories.dart';
import 'package:http/http.dart' as http;

import 'package:lab8_9_10/datamodel/shoes.dart';

import '../datamodel/bill.dart';
import '../datamodel/register.dart';

class API {
  final Dio _dio = Dio();
  String baseUrl = "https://huflit.id.vn:4321";

  API() {
    _dio.options.baseUrl = "$baseUrl/api";
  }

  Dio get sendRequest => _dio;
}

class APIRepository {
  API api = API();

  Map<String, dynamic> header(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
  }
  Future<String> register(Signup user) async {
    try {
      final body = FormData.fromMap({
        "numberID": user.numberID,
        "accountID": user.accountID,
        "fullName": user.fullName,
        "phoneNumber": user.phoneNumber,
        "imageURL": user.imageUrl,
        "birthDay": user.birthDay,
        "gender": user.gender,
        "schoolYear": user.schoolYear,
        "schoolKey": user.schoolKey,
        "password": user.password,
        "confirmPassword": user.confirmPassword
      });
      Response res = await api.sendRequest.post('/Student/signUp',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        print("ok");
        return "ok";
      } else {
        print("fail");
        return "signup fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
  Future<bool> addBill(List<Map<String, dynamic>> products, String token) async {
    var list = [];
    try {
      for (int i = 0; i < products.length; i++) {
        list.add({
          'productID': products[i]['shoes'].id,
          'count': products[i]['amount'],
        });
      }
      Response res = await api.sendRequest.post('/Order/addBill',
          options: Options(headers: header(token)), data: list);
      if (res.statusCode == 200) {
        print("add bill ok");
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
  Future<String> login(String account, String password) async {
    try {
      final body =
      FormData.fromMap({'AccountID': account, 'Password': password});
      Response res = await api.sendRequest.post('/Auth/login',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        final tokenData = res.data['data']['token'];
        print("ok login");
        return tokenData;
      } else {
        return "login fail";
      }
    } catch (ex) {
      print(ex);
      return "login fail";
    }
  }
  Future<User> getCurrentUser(String token)async{
    try {
      final url = 'https://huflit.id.vn:4321/api/Auth/current';
      Response res = await api.sendRequest.get(url,
          options: Options(headers:{
            'Authorization': 'Bearer ${token}'
          }));
      if (res.statusCode == 200) {
        return User.fromJson(res.data);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
  Future<List<Categories>> listCate(String accountID,String token)async{
    try {
      final url = 'https://huflit.id.vn:4321/api/Category/getList';
    Response res = await api.sendRequest.get(url,
        options: Options(headers:{
          'Authorization': 'Bearer ${token}'
        }), queryParameters: {'accountID': accountID});
      if (res.statusCode == 200) {
        List<dynamic> data = res.data;
        return Categories.fromJsonList(data);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
  Future<List<Shoes>> listShoes(String accountID,String token)async{
    try {
      final url = 'https://huflit.id.vn:4321/api/Product/getList';
      Response res = await api.sendRequest.get(url,
          options: Options(headers:{
            'Authorization': 'Bearer ${token}'
          }), queryParameters: {'accountID': accountID});
      if (res.statusCode == 200) {
        List<dynamic> data = res.data;
        return Shoes.fromJsonList(data);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
  Future<List<BillModel>> getHistory(String token) async {
    try {
      Response res = await api.sendRequest
          .get('/Bill/getHistory', options: Options(headers: header(token)));
      return res.data
          .map((e) => BillModel.fromJson(e))
          .cast<BillModel>()
          .toList();
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<BillDetailModel>> getHistoryDetail(
      String billID, String token) async {
    try {
      Response res = await api.sendRequest.post('/Bill/getByID?billID=$billID',
          options: Options(headers: header(token)));
      return res.data
          .map((e) => BillDetailModel.fromJson(e))
          .cast<BillDetailModel>()
          .toList();
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
}
