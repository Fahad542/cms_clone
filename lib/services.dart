

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/customer_check.dart';


class Api{
  static Future<dynamic> Login(String name, String password) async {
    final response = await http.post(
        Uri.parse("https://premierspulse.com/cms/scripts/login_script.php?username=$name&password=$password"),
    );
        // headers: {'Authorization': Constants.API_AUTH_TOKEN});

    if (response.statusCode == 200) {
      return response.body;
      // return lst.map((response) => LoginData.fromJson(response)).toList();
    } else {
      var data = jsonDecode(response.body);
      return null;
    }
  }

  static Future<dynamic> listBranch() async {
    final response = await http.get(
        Uri.parse("https://premierspulse.com/cms/scripts/getBranch.php"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future<dynamic> listReason() async {
    try{
      final response = await http.get(
          Uri.parse("https://premierspulse.com/cms/scripts/getReason.php"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    }catch (e){
      print(e.toString());
    }
  }

  static Future<dynamic> listProduct() async {
    try{
      final response = await http.get(
          Uri.parse("https://premierspulse.com/cms/scripts/getProduct.php"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    }catch (e){
      print(e.toString());
    }

  }

  static Future<dynamic> listbranchname() async {
    try{
      final response = await http.get(
          Uri.parse("https://booster.b2bpremier.com/services/get_branch_list.php"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    }catch (e){
      print(e.toString());
    }

  }

  static Future<dynamic> profileData(String userName) async {
    final response = await http.get(
        Uri.parse("https://premierspulse.com/cms/scripts/get_user_profile.php?username=$userName"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<dynamic> UploadComplain(String customerName,String customerCode,
      String customerNumber,String customerNumberapi,String address,String product,String branch,
      String reason,String remarks,String userName,String shopName, String code) async {
    final response = await http.get(
        Uri.parse("https://premierspulse.com/cms/scripts/upload_complain.php?cname=$customerName&ccode="+
            "$customerCode&cnumber=$customerNumber&address=$address&product=$product"+
            "&branch=$branch&reason=$reason&remarks=$remarks&username=$userName&cshop=$shopName&cnoapi=$customerNumberapi&brcode=$code"));
    print("https://premierspulse.com/cms/scripts/upload_complain.php?cname=$customerName&ccode="+
        "$customerCode&cnumber=$customerNumber&address=$address&product=$product"+
        "&branch=$branch&reason=$reason&remarks=$remarks&username=$userName&cshop=$shopName&cnoapi=$customerNumberapi&brcode=$code");
    if (response.statusCode == 200) {
      print(response.body);
        return true;
    } else {
      // return jsonDecode(response.body);
      return false;
    }
  }


  Future<CustomerResponse> fetchCustomerData(String customerCode, String branchCode) async {
    final String apiUrl = 'https://booster.b2bpremier.com/services/customer_check.php';

    // Building the complete API URL with parameters
    Uri uri = Uri.parse('$apiUrl?customer_code=$customerCode&branch_code=$branchCode');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // API call successful, parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);
        return CustomerResponse.fromJson(data);
      } else {
        // API call failed, handle the error
        print('Failed to fetch data. Status Code: ${response.statusCode}');
        throw Exception('Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions during the API call
      print('Error during API call: $error');
      throw Exception('Error during API call: $error');
    }
  }
}