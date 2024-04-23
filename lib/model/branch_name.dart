import 'dart:convert';

Branchname branchnameFromJson(String str) {
  final jsonData = json.decode(str);
  return Branchname.fromMap(jsonData);
}

String branchToJson(Branchname data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Branchname{
  int? id;
  String? branchname;

  Branchname({
    this.id,
    this.branchname
  });

  factory Branchname.fromMap(Map<String, dynamic> json) => new Branchname(
    id: json["branch_code"],
    branchname: json["branch_name"],
  );

  Map<String, dynamic> toMap() => {
    "branch_code": id,
    "branch_name": branchname,
  };

}