import 'dart:convert';

Reason reasonFromJson(String str) {
  final jsonData = json.decode(str);
  return Reason.fromMap(jsonData);
}

String reasonToJson(Reason data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Reason{
  int? id;
  String? ReasonName;

  Reason({
    this.id,
    this.ReasonName
  });

  factory Reason.fromMap(Map<String, dynamic> json) => new Reason(
    id: json["id"],
    ReasonName: json["reason_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "reason_name": ReasonName,
  };

}
