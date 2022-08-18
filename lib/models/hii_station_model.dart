import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class HiiStationModel {
  final int? idHii;
  final String name;
  final String date;
  final String time;
  final double water;
  final double leftBank;
  final double rightBank;
  final double groundBevel;
  final double lat;
  final double lng;
  final double particleSize;
  final String recordDataTime;
  final String devicePathStorage;
  final double averageVelocyty;
  final double surfaceVelocity;
  final double flowrate;
  final int flagStatus;
  HiiStationModel({
    this.idHii,
    required this.name,
    required this.date,
    required this.time,
    required this.water,
    required this.leftBank,
    required this.rightBank,
    required this.groundBevel,
    required this.lat,
    required this.lng,
    required this.particleSize,
    required this.recordDataTime,
    required this.devicePathStorage,
    required this.averageVelocyty,
    required this.surfaceVelocity,
    required this.flowrate,
    required this.flagStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idHii': idHii,
      'name': name,
      'date': date,
      'time': time,
      'water': water,
      'leftBank': leftBank,
      'rightBank': rightBank,
      'groundBevel': groundBevel,
      'lat': lat,
      'lng': lng,
      'particleSize': particleSize,
      'recordDataTime': recordDataTime,
      'devicePathStorage': devicePathStorage,
      'surfaceVelocity': surfaceVelocity,
      'averageVelocyty': averageVelocyty,
      'flowrate': flowrate,
      'flagStatus': flagStatus,
    };
  }

  factory HiiStationModel.fromMap(Map<String, dynamic> map) {
    return HiiStationModel(
      idHii: map['idHii'] != null ? map['idHii'] as int : null,
      name: map['name'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      water: map['water'] as double,
      leftBank: map['leftBank'] as double,
      rightBank: map['rightBank'] as double,
      groundBevel: map['groundBevel'] as double,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
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

  factory HiiStationModel.fromJson(String source) =>
      HiiStationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
