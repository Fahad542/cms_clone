
import 'dart:convert';

Complain complainFromJson(String str) {
  final jsonData = json.decode(str);
  return Complain.fromMap(jsonData);
}

String complainToJson(Complain data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Complain {
  int? id;
  String? EmployeeName;
  String? EmployeeCode;
  String? ShopName;
  String? EmployeeNumber;
  String? EmployeeRemarks;
  String? ProductName;
  String? BranchName;
  String? Reason;
  String? Address;
  String? EmployeeNumberApi;
  String? code;

  Complain({
    this.id,
    this.EmployeeName,
    this.EmployeeCode,
    this.ShopName,
    this.EmployeeNumber,
    this.EmployeeRemarks,
    this.ProductName,
    this.BranchName,
    this.Reason,
    this.Address,
    this.EmployeeNumberApi,
    this.code
  });

  factory Complain.fromMap(Map<String, dynamic> json) => new Complain(
      id: json["id"],
      EmployeeName: json["employee_name"],
    EmployeeCode: json["employee_code"],
    ShopName: json["shop_name"],
    EmployeeNumber: json["employee_number"],
    EmployeeRemarks: json["employee_remarks"],
    ProductName: json["product_name"],
    BranchName: json["branch_name"],
    Reason: json["reason"],
    Address: json['address'],
      EmployeeNumberApi: json['employee_number_api'],
      code: json['code']
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "employee_name": EmployeeName,
    "employee_code" : EmployeeCode,
    "shop_name":ShopName,
    "employee_number" : EmployeeNumber,
    "employee_remarks" : EmployeeRemarks,
    "product_name" : ProductName,
    "branch_name" : BranchName,
    "reason" : Reason,
    "address" : Address,
    'employee_number_api':EmployeeNumberApi,
    'code':code,

  };
}