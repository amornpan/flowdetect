import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OtherRiverModel {
  final int? idOther;
  final double bVal;
  final double yVal;
  final double aVal;
  final double particleSize;
  final String recordDataTime;
  final String devicePathStorage;
  final double surfaceVelocity;
  final double averageVelocyty;
  final double flowrate;
  final int flagStatus;
  OtherRiverModel({
    this.idOther,
    required this.bVal,
    required this.yVal,
    required this.aVal,
    required this.particleSize,
    required this.recordDataTime,
    required this.devicePathStorage,
    required this.surfaceVelocity,
    required this.averageVelocyty,
    required this.flowrate,
    required this.flagStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idOther': idOther,
      'bVal': bVal,
      'yVal': yVal,
      'aVal': aVal,
      'particleSize': particleSize,
      'recordDataTime': recordDataTime,
      'devicePathStorage': devicePathStorage,
      'surfaceVelocity': surfaceVelocity,
      'averageVelocyty': averageVelocyty,
      'flowrate': flowrate,
      'flagStatus': flagStatus,
    };
  }

  factory OtherRiverModel.fromMap(Map<String, dynamic> map) {
    return OtherRiverModel(
      idOther: map['idOther'] != null ? map['idOther'] as int : null,
      bVal: map['bVal'] as double,
      yVal: map['yVal'] as double,
      aVal: map['aVal'] as double,
      particleSize: map['particleSize'] as double,
      recordDataTime: map['recordDataTime'] as String,
      devicePathStorage: map['devicePathStorage'] as String,
      surfaceVelocity: map['surfaceVelocity'] as double,
      averageVelocyty: map['averageVelocyty'] as double,
      flowrate: map['flowrate'] as double,
      flagStatus: map['flagStatus'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OtherRiverModel.fromJson(String source) => OtherRiverModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
