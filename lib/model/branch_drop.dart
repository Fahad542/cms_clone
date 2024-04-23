import 'dart:convert';

Branch branchFromJson(String str) {
  final jsonData = json.decode(str);
  return Branch.fromMap(jsonData);
}

String branchToJson(Branch data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Branch{
  int? id;
  String? BranchName;

  Branch({
    this.id,
    this.BranchName
  });

  factory Branch.fromMap(Map<String, dynamic> json) => new Branch(
    id: json["id"],
    BranchName: json["branch_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "branch_name": BranchName,
  };

}
