
class Division {
  final int divisionId;
  final String divisionName;

  Division({required this.divisionId, required this.divisionName});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      divisionId: json['DivisionId'],
      divisionName: json['DivisionName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'DivisionId': divisionId,
      'DivisionName': divisionName,
    };
  }
}
