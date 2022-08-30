import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SQLiteModel {
  final int? id;
  final String recordDataTime;
  final String station;
  final String pathStorage;
  SQLiteModel({
    this.id,
    required this.recordDataTime,
    required this.station,
    required this.pathStorage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'recordDataTime': recordDataTime,
      'station': station,
      'pathStorage': pathStorage,
    };
  }

  factory SQLiteModel.fromMap(Map<String, dynamic> map) {
    return SQLiteModel(
      id: (map['id'] ?? 0) as int,
      recordDataTime: (map['recordDataTime'] ?? '') as String,
      station: (map['station'] ?? '') as String,
      pathStorage: (map['pathStorage'] ?? '') as String,
    );
  }

  factory SQLiteModel.fromJson(String source) =>
      SQLiteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
