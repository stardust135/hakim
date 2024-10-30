class BloodPressure {
  final int? id;
  final int systolic;
  final int diastolic;
  final int pulse;
  final DateTime dateTime;

  BloodPressure({
    this.id,
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'systolic': systolic,
      'diastolic': diastolic,
      'pulse': pulse,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  static BloodPressure fromMap(Map<String, dynamic> map) {
    return BloodPressure(
      id: map['id'],
      systolic: map['systolic'],
      diastolic: map['diastolic'],
      pulse: map['pulse'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}
