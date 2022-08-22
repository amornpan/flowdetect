import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OtherRiverModel {
  final int? idOther;
  final double bVal;
  final double yVal;
  final double aVal;
  final double otherRiverparticleSize;
  final String otherRiverrecordDataTime;
  final String otherRiverdevicePathStorage;
  final double otherRiversurfaceVelocity;
  final double otherRiveraverageVelocity;
  final double otherRiverflowrate;
  final int otherRiverflagStatus;
  OtherRiverModel({
    this.idOther,
    required this.bVal,
    required this.yVal,
    required this.aVal,
    required this.otherRiverparticleSize,
    required this.otherRiverrecordDataTime,
    required this.otherRiverdevicePathStorage,
    required this.otherRiversurfaceVelocity,
    required this.otherRiveraverageVelocity,
    required this.otherRiverflowrate,
    required this.otherRiverflagStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idOther': idOther,
      'bVal': bVal,
      'yVal': yVal,
      'aVal': aVal,
      'otherRiverparticleSize': otherRiverparticleSize,
      'otherRiverrecordDataTime': otherRiverrecordDataTime,
      'otherRiverdevicePathStorage': otherRiverdevicePathStorage,
      'otherRiversurfaceVelocity': otherRiversurfaceVelocity,
      'otherRiveraverageVelocity': otherRiveraverageVelocity,
      'otherRiverflowrate': otherRiverflowrate,
      'otherRiverflagStatus': otherRiverflagStatus,
    };
  }

  factory OtherRiverModel.fromMap(Map<String, dynamic> map) {
    return OtherRiverModel(
      idOther: map['idOther'] != null ? map['idOther'] as int : null,
      bVal: map['bVal'] as double,
      yVal: map['yVal'] as double,
      aVal: map['aVal'] as double,
      otherRiverparticleSize: map['otherRiverparticleSize'] as double,
      otherRiverrecordDataTime: map['otherRiverrecordDataTime'] as String,
      otherRiverdevicePathStorage: map['otherRiverdevicePathStorage'] as String,
      otherRiversurfaceVelocity: map['otherRiversurfaceVelocity'] as double,
      otherRiveraverageVelocity: map['otherRiveraverageVelocity'] as double,
      otherRiverflowrate: map['otherRiverflowrate'] as double,
      otherRiverflagStatus: map['otherRiverflagStatus'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OtherRiverModel.fromJson(String source) => OtherRiverModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
