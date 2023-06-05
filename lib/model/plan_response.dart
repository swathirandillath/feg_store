// To parse this JSON data, do
//
//     final planList = planListFromJson(jsonString);

import 'dart:convert';

PlanList planListFromJson(String str) => PlanList.fromJson(json.decode(str));

String planListToJson(PlanList data) => json.encode(data.toJson());

class PlanList {
  List<dynamic> activePlan;
  List<dynamic> inactivePlan;

  PlanList({
    required this.activePlan,
    required this.inactivePlan,
  });

  factory PlanList.fromJson(Map<String, dynamic> json) => PlanList(
    activePlan: List<dynamic>.from(json["active_plan"].map((x) => x)),
    inactivePlan: List<dynamic>.from(json["inactive_plan"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "active_plan": List<dynamic>.from(activePlan.map((x) => x)),
    "inactive_plan": List<dynamic>.from(inactivePlan.map((x) => x)),
  };
}
