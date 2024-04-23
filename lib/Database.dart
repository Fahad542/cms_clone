
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:premier_cms/model/branch_drop.dart';
import 'package:premier_cms/model/branch_name.dart';
import 'package:premier_cms/model/complain_model.dart';
import 'package:premier_cms/model/product_drop.dart';
import 'package:premier_cms/model/reason_drop.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();


  static Database? _database;

  Future<Database> get database async {
    if (_database != null)
      return _database!;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "complainss3.db");
    return await openDatabase(path, version: 1, onOpen: (db) {

    }, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Complain (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, employee_name TEXT, employee_code TEXT, shop_name TEXT, employee_number TEXT,employee_number_api TEXT, employee_remarks TEXT, product_name TEXT, branch_name TEXT, reason TEXT, address TEXT, code TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Product (id INTEGER PRIMARY KEY, product_name TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Branch (id INTEGER PRIMARY KEY, branch_name TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS BranchName (branch_code INTEGER PRIMARY KEY, branch_name TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Reason (id INTEGER PRIMARY KEY, reason_name TEXT)');

    });
  }


  newClient(Reason newClient) async {
    final db = await database;
    var res = await db.insert("Reason", newClient.toMap());
    print(res.toString()+"mxomijxnijxjanxjia");
    return res;
  }

  newClientProduct(Product newClient) async {
    final db = await database;
    var res = await db.insert("Product", newClient.toMap());
    print(res.toString()+"mxomijxnijxjanxjian ckn kcnsjcnsjkcnskjcnskcjn");
    return res;
  }

  newClientComplain(Complain newClient) async {
    final db = await database;
    var res = await db.insert("Complain", newClient.toMap());
    return res;
  }

  complainRawInsert(String EmployeeName, String EmployeeCode, String ShopName,
      String EmployeeNumber,String EmployeeNumberApi, String EmployeeRemarks, String ProductName,
      String BranchName, String Reason, String Address, String code ) async {
    final db = await database;
    var res = await db.rawQuery(
        "INSERT INTO Complain(employee_name, employee_code, shop_name, employee_number,employee_number_api, employee_remarks, product_name, branch_name, reason, address, code) VALUES ('$EmployeeName', '$EmployeeCode', '$ShopName', '$EmployeeNumber','$EmployeeNumberApi', '$EmployeeRemarks', '$ProductName', '$BranchName', '$Reason', '$Address', $code)");
    return res;
  }

  deleteClient(int id) async {
    final db = await database;
    db.delete("Complain", where: "id = ?", whereArgs: [id]);
  }

  newClientBranch(Branch newClient) async {
    final db = await database;
    var res = await db.insert("Branch", newClient.toMap());
    // print(res.toString()+"mxomijxnijxjanxjian ckn kcnsjcnsjkcnskjcnskcjnkijbygvhbjhcu hv uf hi ugf g gugguv ");
    return res;
  }
  newClientBranchName(Branchname newClient) async {
    try {
      final db = await database;
      var res = await db.insert("BranchName", newClient.toMap());
      print("Insert result: $res");
      return res;
    } catch (e) {
      print("Error inserting into BranchName table: $e");
      return null; // Handle the error according to your needs
    }
  }

  getAllClientsComplain() async {
    final db = await database;
    var res = await db.query("Complain");
    List<Complain> list =
    res.isNotEmpty ? res.map((c) => Complain.fromMap(c)).toList() : [];
    print(list.length.toString()+"this is the lenght of the rpouct");
    return list;
  }

  getAllClientsProduct() async {
    final db = await database;
    var res = await db.query("Product");
    List<Product> list =
    res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    print(list.length.toString()+"this is the lenght of the rpouct");
    return list;
  }

  getAllClientsBranch() async {
    final db = await database;
    var res = await db.query("Branch");
    List<Branch> list =
    res.isNotEmpty ? res.map((c) => Branch.fromMap(c)).toList() : [];
    print(list.length.toString()+"this is the lenght of the branch");
    return list;
  }
  getAllClientsBranchName() async {
    final db = await database;
    var res = await db.query("BranchName");
    List<Branchname> list =
    res.isNotEmpty ? res.map((c) => Branchname.fromMap(c)).toList() : [];
    print(list.length.toString()+"this is the lenght of the branchname");
    return list;
  }

  getAllClients() async {
    final db = await database;
    var res = await db.query("Reason");
    List<Reason> list =
    res.isNotEmpty ? res.map((c) => Reason.fromMap(c)).toList() : [];
    print(list.length.toString()+"this is the lenght");
    return list;
  }

  deleteAllPRoduct() async {
    final db = await database;
    db.delete("Product");
  }

  deleteAllBranch() async {
    final db = await database;
    db.delete("Branch");
  }

  deleteAllReason() async {
    final db = await database;
    db.delete("Reason");
  }

  deleteAllComplain() async {
    final db = await database;
    db.delete("Complain");
  }

  deleteAllBranchName() async {
    final db = await database;
    db.delete("BranchName");
  }
}